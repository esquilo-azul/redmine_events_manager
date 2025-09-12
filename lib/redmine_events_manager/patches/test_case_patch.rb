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
                        .included_modules.exclude?(RedmineEventsManager::Patches::TestCasePatch)
  ActiveSupport::TestCase.include RedmineEventsManager::Patches::TestCasePatch # rubocop:disable Rails/ActiveSupportOnLoad
end
