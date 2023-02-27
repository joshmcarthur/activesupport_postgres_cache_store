# frozen_string_literal: true

require "active_support/cache"
require "active_record"

module ActiveSupport
  module Cache
    ##
    # Implements an ActiveSupport::Cache::Store which reads and writes data into a Postgres table
    # This allows for a simple cache store using your existing data store.
    class PostgresqlStore < Store
      # Advertise cache versioning support.
      def self.supports_cache_versioning?
        true
      end

      def initialize(options = {})
        super(options)
        CacheRecord.table_name = options[:table_name] || "activesupport_cache_store"
      end

      def write_entry(key, value, options = {})
        value = Marshal.dump(value)
        expires_at = options[:expires_in] ? Time.current + options[:expires_in] : nil
        CacheRecord.upsert({ key: key, value: value, expires_at: expires_at }, unique_by: :key)
      end

      def read_entry(key, _options = {})
        record = CacheRecord.find_by(key: key)
        Marshal.load(record.value) if record && (!record.expires_at || record.expires_at >= Time.current) # rubocop:disable Security/MarshalLoad
      end

      def delete_entry(key, _options = {})
        CacheRecord.where(key: key).delete_all
      end

      def clear(_options = {})
        CacheRecord.delete_all
      end

      ##
      # A simple key-value ActiveRecord table
      class CacheRecord < ActiveRecord::Base
      end
    end
  end
end
