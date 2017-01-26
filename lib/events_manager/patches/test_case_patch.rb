module EventsManager
  module Patches
    module TestCasePatch
      def self.included(base)
        base.setup do
          EventsManager.delay_disabled = true
          EventsManager.log_exceptions_disabled = true
          EventsManager::Settings.event_exception_unchecked = false
        end
      end
    end
  end
end

if Rails.env.test?
  require Rails.root.join('test', 'test_helper.rb')
  unless ::ActiveSupport::TestCase.included_modules.include? EventsManager::Patches::TestCasePatch
    ::ActiveSupport::TestCase.send(:include, EventsManager::Patches::TestCasePatch)
  end
end
