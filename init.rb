# coding: utf-8

require 'redmine'

require 'events_manager/patches/issue_patch'
require 'events_manager/patches/issue_relation_patch'
require 'events_manager/patches/journal_patch'
require 'events_manager/patches/test_case_patch'
require 'events_manager/patches/time_entry_patch'
require 'events_manager/patches/repository/git_patch'
require 'events_manager'
require_dependency 'events_manager/hooks/add_assets'

Redmine::Plugin.register :redmine_events_manager do
  name 'Events Manager'
  author 'Eduardo Henrique Bogoni'
  description 'Management for events'
  version '0.4.4'

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
