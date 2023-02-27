# activesupport_postgres_cache_store

`activesupport_postgres_cache_store` is a Ruby gem that provides an implementation of `ActiveSupport::Cache::Store` that stores cache data in a PostgreSQL table.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postgresql-cache-store'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install postgresql-cache-store
```

Generate the migration for the `activestorage_cache_store` table:

```shell
bin/rails generate activesupport_postgres_cache_store:migration
```

By default, the cache table will be created with the name `activesupport_cache_store` and will be a normal PostgreSQL table.

## Usage

To use the PostgreSQL cache store in your Rails application, you can configure it in your config/application.rb file:

```ruby
config.cache_store = :activesupport_postgres_cache_store,
                     expires_in: 1.hour
```

This will configure the cache store to use a PostgreSQL table called `activesupport_cache_store`, with non-expiring cache entries

Alternatively, you can configure the cache store in an initializer file, such as config/initializers/cache_store.rb:

```ruby
Rails.application.config.cache_store = :postgresql_cache_store,
                                       expires_in: 1.hour
```

## Options

The following options can be passed to the cache store:

- `table_name`: The name of the PostgreSQL table to use for storing cache data. Defaults to activesupport_cache_store.
- `expires_in`: The default expiration time for cache entries, in seconds. Set to nil to disable expiration (not recommended).

## Features

The postgresql-cache-store gem supports the following features:

- Storing and retrieving cache data in a PostgreSQL table
- Expiring cache entries after a specified time period
- Generating a migration file for creating the cache table using the `activesupport_postgres_cache_store:migration` generator

## Development

After checking out the repo, run bin/setup to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshmcarthur/activesupport_postgres_cache_store. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/license/mit/).
