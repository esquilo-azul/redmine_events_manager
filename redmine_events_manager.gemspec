# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'redmine_events_manager/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'redmine_events_manager'
  s.version     = ::RedmineEventsManager::VERSION # rubocop:disable Style/RedundantConstantBase
  s.authors     = [::RedmineEventsManager::AUTHOR] # rubocop:disable Style/RedundantConstantBase
  s.summary     = ::RedmineEventsManager::SUMMARY # rubocop:disable Style/RedundantConstantBase
  s.homepage    = ::RedmineEventsManager::HOMEPAGE # rubocop:disable Style/RedundantConstantBase

  s.require_paths = ['lib']
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files spec test`.split("\n") # rubocop:disable Gemspec/DeprecatedAttributeAssignment
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'delayed_job_active_record', '~> 4.1', '>= 4.1.11'

  # Test/development gems
  s.add_development_dependency 'eac_rails_gem_support', '~> 0.11'
end
