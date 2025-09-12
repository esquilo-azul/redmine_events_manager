# frozen_string_literal: true

module RedmineEventsManager
  module Patches
    module TestCasePatch
      def self.included(base)
        base.setup { ::RedmineEventsManager::TestConfig.new.before_each }
      end
    end
  end
end

if Rails.env.test? && ::ActiveSupport::TestCase # rubocop:disable Style/RedundantConstantBase
                        .included_modules.exclude?(EventsManager::Patches::TestCasePatch)
  ActiveSupport::TestCase.include EventsManager::Patches::TestCasePatch # rubocop:disable Rails/ActiveSupportOnLoad
end
