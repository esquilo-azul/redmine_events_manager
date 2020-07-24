# frozen_string_literal: true

module EventsManager
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
          EventsManager.trigger(Issue, :create, self)
        end

        def issue_destroy_event
          EventsManager.trigger(Issue, :delete, self)
        end
      end
    end
  end
end

unless Issue.included_modules.include? EventsManager::Patches::IssuePatch
  Issue.include EventsManager::Patches::IssuePatch
end
