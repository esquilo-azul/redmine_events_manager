module EventsManager
  module Patches
    module Hooks
      module RedminePatch
        def self.included(base)
          base.send(:include, InstanceMethods)

          base.class_eval do
            unloadable

            alias_method_chain :execute, :trigger_event
          end
        end

        module InstanceMethods
          def execute_with_trigger_event
            execute_without_trigger_event
            EventsManager::EventManager.trigger(Repository, :receive, repository)
          end
        end
      end
    end
  end
end

require File.expand_path('plugins/redmine_git_hosting/app/services/hooks/redmine')

unless Hooks::Redmine.included_modules.include? EventsManager::Patches::Hooks::RedminePatch
  Hooks::Redmine.send(:include, EventsManager::Patches::Hooks::RedminePatch)
end
