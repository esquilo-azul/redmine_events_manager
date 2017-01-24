module EventsManager
  module Patches
    module Repository
      module GitPatch
        def self.included(base)
          base.send(:include, InstanceMethods)

          base.class_eval do
            alias_method_chain :fetch_changesets, :trigger_event
          end
        end

        module InstanceMethods
          def fetch_changesets_with_trigger_event
            fetch_changesets_without_trigger_event
            EventsManager.trigger(::Repository, :receive, self)
          end
        end
      end
    end
  end
end

unless ::Repository::Git.included_modules.include?(EventsManager::Patches::Repository::GitPatch)
  ::Repository::Git.include(EventsManager::Patches::Repository::GitPatch)
end
