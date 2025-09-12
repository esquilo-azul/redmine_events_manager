# frozen_string_literal: true

module EventsManager
  module Patches
    module TestCasePatch
      def self.included(base)
        base.setup { ::RedmineEventsManager::TestConfig.new.before_each }
      end
    end
  end
end

if Rails.env.test? && !::ActiveSupport::TestCase.included_modules.include?(EventsManager::Patches::TestCasePatch)
  ::ActiveSupport::TestCase.include EventsManager::Patches::TestCasePatch
end
