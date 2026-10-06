# frozen_string_literal: true

require 'redmine'
require 'redmine_events_manager/version'

Redmine::Plugin.register :redmine_events_manager do
  name 'Events Manager'
  author ::RedmineEventsManager::AUTHOR # rubocop:disable Style/RedundantConstantBase
  description ::RedmineEventsManager::SUMMARY # rubocop:disable Style/RedundantConstantBase
  version ::RedmineEventsManager::VERSION # rubocop:disable Style/RedundantConstantBase

  settings default: { event_exception_unchecked: false }
end
