require 'farfugl/railtie' if defined? Rails
require 'farfugl/git'

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

  def self.hashes(migrations)
    migrations.map { |file| Git.hash(file) }
  end

  def self.migrate
    Git.stash
    original_branch = Git.current_branch
    hashes = hashes(pending_migrations(schema_versions))
    hashes.each do |commit_hash|
      Git.checkout(commit_hash)
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:migrate'].reenable
    end
    Git.checkout(original_branch)
    Git.unstash
    Rake::Task['db:schema:dump'].invoke
  end
end
