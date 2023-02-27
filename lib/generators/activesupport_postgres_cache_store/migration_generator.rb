# frozen_string_literal: true

require "rails/generators"
require "rails/generators/active_record"

module ActivesupportPostgresCacheStore
  ##
  # Generates an ActiveRecord migration for the cache store table
  # Run using: `rails generate active_support_postgres_cache_store:migration`
  # Available options:
  #   * table_name: Use a different table name from activesupport_cache_store
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("templates", __dir__)

    class_option :table_name, type: :string, default: "activesupport_cache_store",
                              desc: "The name of the cache table to be created"

    def create_migration_file
      migration_file_name = "create_#{table_name}_table.rb"
      migration_template "migration.rb.erb", "db/migrate/#{migration_file_name}", table_name: table_name
    end

    def self.next_migration_number(dirname)
      ::ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

    private

    def table_name
      options[:table_name]
    end
  end
end
