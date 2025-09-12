# frozen_string_literal: true

module RedmineEventsManager
  module Patches
    module IssuePatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          after_create :issue_create_event
          after_destroy :issue_destroy_event
        end
      end

      module InstanceMethods
        def issue_create_event
          RedmineEventsManager.trigger(Issue, :create, self)
        end

        def issue_destroy_event
          RedmineEventsManager.trigger(Issue, :delete, self)
        end
      end
    end
  end
end

unless Issue.included_modules.include? RedmineEventsManager::Patches::IssuePatch
  Issue.include RedmineEventsManager::Patches::IssuePatch
end
