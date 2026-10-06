# frozen_string_literal: true

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
              User.current.admin? && RedmineEventsManager::Settings.event_exception_unchecked
            }
end
