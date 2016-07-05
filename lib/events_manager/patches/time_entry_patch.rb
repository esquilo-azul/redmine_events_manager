module EventsManager
  module Patches
    module TimeEntryPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          after_create :time_entry_create_event
          after_destroy :time_entry_destroy_event
          after_update :time_entry_update_event
        end
      end

      module InstanceMethods
        def time_entry_create_event
          EventsManager.trigger(TimeEntry, :create, self)
        end

        def time_entry_destroy_event
          EventsManager.trigger(TimeEntry, :delete,
                                EventsManager::RemovedRecord.new(self))
        end

        def time_entry_update_event
          EventsManager.trigger(TimeEntry, :update,
                                EventsManager::UpdatedRecord.new(self))
        end
      end
    end
  end
end

unless TimeEntry.included_modules.include? EventsManager::Patches::TimeEntryPatch
  TimeEntry.send(:include, EventsManager::Patches::TimeEntryPatch)
end
