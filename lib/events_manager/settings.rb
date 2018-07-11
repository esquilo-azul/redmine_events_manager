module EventsManager
  class Settings
    class << self
      def event_exception_unchecked=(value)
        s = Setting.plugin_redmine_events_manager.dup || {}
        s[:event_exception_unchecked] = value ? true : false
        Setting.plugin_redmine_events_manager = s
      end

      def event_exception_unchecked
        Setting.plugin_redmine_events_manager[:event_exception_unchecked] ? true : false
      end
    end
  end
end
