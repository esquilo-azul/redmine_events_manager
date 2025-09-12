# frozen_string_literal: true

module RedmineEventsManager
  class TestConfig
    def before_each
      RedmineEventsManager.delay_disabled = true
      RedmineEventsManager.log_exceptions_disabled = true
      RedmineEventsManager::Settings.event_exception_unchecked = false
    end
  end
end
