# frozen_string_literal: true

Redmine::Plugin.post_register :redmine_events_manager do
  # Source: https://github.com/esquilo-azul/redmine_nonproject_modules
  requires_redmine_plugin(:redmine_nonproject_modules, version_or_higher: '0.2.1')
end
