# frozen_string_literal: true

module RedmineEventsManager
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
          RedmineEventsManager.trigger(TimeEntry, :create, self)
        end

        def time_entry_destroy_event
          RedmineEventsManager.trigger(TimeEntry, :delete,
                                       RedmineEventsManager::RemovedRecord.new(self))
        end

        def time_entry_update_event
          RedmineEventsManager.trigger(TimeEntry, :update,
                                       RedmineEventsManager::UpdatedRecord.new(self))
        end
      end
    end
  end
end

unless TimeEntry.included_modules.include? RedmineEventsManager::Patches::TimeEntryPatch
  TimeEntry.include RedmineEventsManager::Patches::TimeEntryPatch
end
