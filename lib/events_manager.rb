module EventsManager
  class << self
    attr_accessor :delay_disabled

    def add_listener(entity, action, listener)
      return if listeners(entity, action).include?(listener)
      listeners(entity, action) << listener
    end

    def trigger(entity, action, data)
      event = EventsManager::Event.new(entity, action, data)
      Rails.logger.debug("Event triggered: #{event}")
      listeners(entity, action).each do |l|
        Rails.logger.debug("Listener found: #{l}")
        run_delayed_listener(l.constantize.new(event))
      end
    end

    private

    def run_delayed_listener(listener)
      if delay_disabled
        run_listener(listener)
      else
        delay.run_listener(listener)
      end
    end

    def run_listener(listener)
      previous_locale = I18n.locale
      begin
        Rails.logger.info("Running listener: #{listener}")
        I18n.locale = Setting.default_language
        listener.run
      rescue => ex
        Rails.logger.warn(ex)
      ensure
        I18n.locale = previous_locale
      end
    end

    def listeners(entity, action)
      @listeners ||= {}
      @listeners[entity] ||= {}
      @listeners[entity][action] ||= []
    end
  end
end
