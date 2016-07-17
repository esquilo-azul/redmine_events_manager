require 'test_helper'

module ActiveSupport
  class TestCase
    setup do
      EventsManager.delay_disabled = true
    end
  end
end
