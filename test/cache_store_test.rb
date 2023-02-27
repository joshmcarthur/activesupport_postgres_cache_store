# frozen_string_literal: true

require "test/unit"
require "active_support/testing/assertions"
require_relative "../lib/activesupport_postgres_cache_store"

class ActiveSupportPostgresCacheStoreTest < ActiveSupport::TestCase
  include ActiveSupport::Testing::Assertions

  def setup_database
    ActiveRecord::Base.establish_connection(
      ENV["DATABASE_URL"] || { adapter: :postgresql, database: "activesupport_postgres_cache_store_test" }
    )
    ActiveRecord::Base.connection.execute <<~SQL
      CREATE TABLE IF NOT EXISTS
        activesupport_cache_store_test
        (key TEXT PRIMARY KEY NOT NULL, value BYTEA NOT NULL, expires_at TIMESTAMP);
      CREATE UNIQUE INDEX IF NOT EXISTS
        activesupport_cache_store_test_key ON
          activesupport_cache_store_test (key);
    SQL
  end

  def setup
    setup_database

    @cache_store = ActiveSupport::Cache::PostgresqlStore.new(
      table_name: "activesupport_cache_store_test"
    )
    @cache_store.clear
  end

  def test_write_entry_and_read_entry
    key = "test_key"
    value = "test_value"
    options = { expires_in: 1.minute }
    @cache_store.write(key, value, options)
    assert_equal(value, @cache_store.read(key))
  end

  def test_write_entry_with_no_expiration
    key = "test_key"
    value = "test_value"
    @cache_store.write(key, value)
    assert_equal(value, @cache_store.read(key))
  end

  def test_write_entry_with_nil_expiration
    key = "test_key"
    value = "test_value"
    options = { expires_in: nil }
    @cache_store.write(key, value, options)
    assert_equal(value, @cache_store.read(key))
  end

  def test_read_expired_entry
    key = "test_key"
    value = "test_value"
    options = { expires_in: 1.second }
    @cache_store.write(key, value, options)
    sleep(2)
    assert_nil(@cache_store.read(key))
  end

  def test_delete_entry
    key = "test_key"
    value = "test_value"
    @cache_store.write(key, value)
    @cache_store.delete(key)
    assert_nil(@cache_store.read(key))
  end
end
