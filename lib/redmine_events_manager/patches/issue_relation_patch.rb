# frozen_string_literal: true

module RedmineEventsManager
  module Patches
    module IssueRelationPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          after_create :issue_relation_create_event
          after_destroy :issue_relation_destroy_event
        end
      end

      module InstanceMethods
        def issue_relation_create_event
          RedmineEventsManager.trigger(IssueRelation, :create, self)
        end

        def issue_relation_destroy_event
          RedmineEventsManager.trigger(IssueRelation, :delete, self)
        end
      end
    end
  end
end

unless IssueRelation.included_modules.include? RedmineEventsManager::Patches::IssueRelationPatch
  IssueRelation.include RedmineEventsManager::Patches::IssueRelationPatch
end
