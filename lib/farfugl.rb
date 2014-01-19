require 'farfugl/railtie' if defined? Rails

module Farfugl
  def self.schema_versions
    schema_table = ActiveRecord::Migrator.schema_migrations_table_name
    query = "SELECT version FROM #{schema_table}"
    ActiveRecord::Base.connection.select_values(query)
      .map { |version| "%.3d" % version }
  end

  def self.pending_migrations(versions)
    migrations = []
    ActiveRecord::Migrator.migrations_paths.each do |path|
      Dir.foreach(path) do |file|
        if match_data = /^(\d{3,})_(.+)\.rb$/.match(file)
          migrations << "#{path}/#{file}" unless versions.delete(match_data[1])
        end
      end
    end
    migrations
  end

  def self.hash(file)
    `git log -n 1 -- #{file}`.split[1]
  end

  def self.hashes(migrations)
    migrations.map { |file| self.hash(file) }
  end

  def self.stash
    `git stash -u`
  end

  def self.unstash
    `git stash pop`
  end

  def self.current_branch
    `git rev-parse --abbrev-ref HEAD`
  end

  def self.checkout(destination)
    `git checkout -f #{destination}`
  end

  def self.migrate
    self.stash
    original_branch = self.current_branch
    hashes = self.hashes(self.pending_migrations(self.schema_versions))
    hashes.each do |commit_hash|
      self.checkout(commit_hash)
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:migrate'].reenable
    end
    self.checkout(original_branch)
    self.unstash
  end
end
