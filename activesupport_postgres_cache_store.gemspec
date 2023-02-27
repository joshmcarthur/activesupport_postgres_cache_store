# frozen_string_literal: true

require_relative "lib/activesupport_postgres_cache_store/version"

Gem::Specification.new do |spec|
  spec.name = "activesupport_postgres_cache_store"
  spec.version = ActivesupportPostgresCacheStore::VERSION
  spec.authors = ["Josh McArthur"]
  spec.email = ["joshua.mcarthur@gmail.com"]

  spec.summary = <<~SUMMARY
    The activesupport_postgres_cache_store gem provides a PostgreSQL-backed implementation of the
    ActiveSupport::Cache::Store interface for Ruby applications."
  SUMMARY

  spec.description = <<~DESC
    The activesupport_postgres_cache_store gem provides an implementation of the
    ActiveSupport::Cache::Store interface that stores cache data in a PostgreSQL
    table. It allows you to easily use a PostgreSQL database for caching data in
    your Ruby applications, providing a durable and scalable solution. The gem
    supports setting an expiration time for cached data, as well as deleting
    individual cache entries or sets of entries matching a pattern.
  DESC

  spec.homepage = "https://github.com/joshmcarthur/activesupport_postgres_cache_store"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activerecord", "> 6.1"
  spec.add_dependency "activesupport", "> 6.1"
  spec.add_dependency "pg"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
