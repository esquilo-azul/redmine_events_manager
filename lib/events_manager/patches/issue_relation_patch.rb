# frozen_string_literal: true

module EventsManager
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
          EventsManager.trigger(IssueRelation, :create, self)
        end

        def issue_relation_destroy_event
          EventsManager.trigger(IssueRelation, :delete, self)
        end
      end
    end
  end
end

unless IssueRelation.included_modules.include? EventsManager::Patches::IssueRelationPatch
  IssueRelation.include EventsManager::Patches::IssueRelationPatch
end
