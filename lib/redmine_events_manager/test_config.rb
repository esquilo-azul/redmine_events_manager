# frozen_string_literal: true

module RedmineEventsManager
  class TestConfig
    def before_each
      EventsManager.delay_disabled = true
      EventsManager.log_exceptions_disabled = true
      EventsManager::Settings.event_exception_unchecked = false
    end
  end
end
