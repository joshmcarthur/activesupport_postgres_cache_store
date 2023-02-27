# frozen_string_literal: true

require "test_helper"
require "rails/generators/test_case"
require "generators/activesupport_postgres_cache_store/migration_generator"

class ActiveSupportPostgresCacheStoreMigrationGeneratorTest < Rails::Generators::TestCase
  tests ActivesupportPostgresCacheStore::MigrationGenerator
  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  test "generate migration" do
    run_generator %w[--table-name cache_values]

    assert_migration "db/migrate/create_cache_values_table.rb" do |migration|
      assert_includes migration, "create_table :cache_values, timestamps: false, id: false do |t|"
      refute_includes migration, "t.string :key, null: false, index: { unique: true }"
      assert_includes migration, "t.binary :value, null: false"
      assert_includes migration, "t.datetime :expires_at"
    end
  end

  test "generate migration without table name and logged table" do
    run_generator

    assert_migration "db/migrate/create_activesupport_cache_store_table.rb" do |migration|
      assert_includes migration,
                      "create_table :activesupport_cache_store, timestamps: false, id: false do |t|"
      refute_includes migration, "t.string :key, null: false, index: { unique: true }"
      assert_includes migration, "t.binary :value, null: false"
      assert_includes migration, "t.datetime :expires_at"
    end
  end
end
