require 'test_helper'

module ActiveSupport
  class TestCase
    setup do
      EventsManager.delay_disabled = true
      EventsManager::Settings.event_exception_unchecked = false
    end
  end
end
