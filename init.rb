# frozen_string_literal: true

require 'redmine'
require_dependency 'redmine_events_manager/version'

Redmine::Plugin.register :redmine_events_manager do
  name 'Events Manager'
  author ::RedmineEventsManager::AUTHOR # rubocop:disable Style/RedundantConstantBase
  description ::RedmineEventsManager::SUMMARY # rubocop:disable Style/RedundantConstantBase
  version ::RedmineEventsManager::VERSION # rubocop:disable Style/RedundantConstantBase

  settings default: { event_exception_unchecked: false }

  Redmine::MenuManager.map :admin_menu do |menu|
    menu.push :event_exceptions, { controller: 'event_exceptions', action: 'index', id: nil },
              caption: :label_event_exception_plural
    menu.push :listener_options, { controller: 'listener_options', action: 'index', id: nil },
              caption: :label_listener_option_plural
  end

  Redmine::MenuManager.map :top_menu do |menu|
    menu.push :event_exception_unchecked,
              { controller: 'event_exceptions', action: 'index', id: nil },
              caption: '', last: true, if: proc {
                User.current.admin? && EventsManager::Settings.event_exception_unchecked
              }
  end
end
