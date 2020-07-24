# frozen_string_literal: true

module EventsManager
  module Patches
    module JournalPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          after_create :journal_create_event
        end
      end

      module InstanceMethods
        def journal_create_event
          return unless journalized_type == 'Issue'

          EventsManager.trigger(Issue, :update, self)
        end
      end
    end
  end
end

unless Journal.included_modules.include? EventsManager::Patches::JournalPatch
  Journal.include EventsManager::Patches::JournalPatch
end
