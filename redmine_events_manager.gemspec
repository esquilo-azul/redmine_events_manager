# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'redmine_events_manager/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'redmine_events_manager'
  s.version     = ::RedmineEventsManager::VERSION
  s.authors     = [::RedmineEventsManager::AUTHOR]
  s.summary     = ::RedmineEventsManager::SUMMARY
  s.homepage    = ::RedmineEventsManager::HOMEPAGE

  s.require_paths = ['lib']
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files spec test`.split("\n")

  s.add_dependency 'delayed_job_active_record', '~> 4.1', '>= 4.1.11'

  # Test/development gems
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5', '>= 0.5.1'
end
