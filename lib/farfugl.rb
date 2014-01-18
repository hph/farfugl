require 'farfugl/railtie' if defined? Rails

module Farfugl
  def self.schema_versions
    schema_table = ActiveRecord::Migrator.schema_migrations_table_name
    query = "SELECT version FROM #{schema_table}"
    versions = ActiveRecord::Base.connection.select_values(query)
    versions.map! { |version| "%.3d" % version }
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

  def self.hashes(migrations)
    migrations.map { |file| `git log -n 1 -- #{file}`.split[1] }
  end

  def self.current_branch
    `git rev-parse --abbrev-ref HEAD`
  end

  def self.untracked_files
    `git status --porcelain 2>/dev/null| grep "^??" | wc -l`
  end

  def self.checkout(destination)
    `git checkout -f #{destination}`
  end

  def self.migrate
    original_branch = self.current_branch
    hashes = self.hashes(self.pending_migrations(self.schema_versions))
    hashes.each do |commit_hash|
      self.checkout(commit_hash)
      Rake::Task['db:migrate'].invoke
    end
    self.checkout(original_branch)
  end
end
