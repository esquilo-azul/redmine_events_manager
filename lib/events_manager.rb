# frozen_string_literal: true

module EventsManager
  class << self
    attr_accessor :delay_disabled, :log_exceptions_disabled

    EVENT_EXCEPTION_ATTRIBUTES = {
      event_entity: proc { |e, _l, _ex| e.entity.name },
      event_action: proc { |e, _l, _ex| e.action.to_s },
      event_data: proc { |e, _l, _ex| e.data.to_yaml },
      listener_class: proc { |_e, l, _ex| l.class.name },
      listener_instance: proc { |_e, l, _ex| l.to_s },
      exception_class: proc { |_e, _l, ex| ex.class.name },
      exception_message: proc { |_e, _l, ex| ex.message },
      exception_stack: proc { |_e, _l, ex| ex.backtrace.join("\n") }
    }.freeze

    def add_listener(entity, action, listener)
      return if listeners(entity, action).include?(listener)

      listeners(entity, action) << listener.to_s
    end

    def trigger(entity, action, data)
      event = EventsManager::Event.new(entity, action, data)
      Rails.logger.debug("Event triggered: #{event}")
      listeners(entity, action).each do |l|
        Rails.logger.debug("Listener found: #{l}")
        run_delayed_listener(event, l.constantize.new(event))
      end
    end

    def all_listeners
      r = []
      @listeners.each_value do |e|
        e.each_value do |a|
          r += a
        end
      end
      r.uniq
    end

    private

    def run_delayed_listener(event, listener)
      return unless ::ListenerOption.listener_enabled?(listener.class)

      if delay_disabled
        run_listener(event, listener)
      else
        delay(run_at: ::ListenerOption.listener_delay(listener.class).seconds.from_now)
          .run_listener(event, listener)
      end
    end

    def run_listener(event, listener)
      previous_locale = I18n.locale
      begin
        Rails.logger.info("Running listener: #{listener}")
        I18n.locale = Setting.default_language
        listener.run
      rescue StandardError => e
        on_listener_exception(event, listener, e)
      ensure
        I18n.locale = previous_locale
      end
    end

    def on_listener_exception(event, listener, exception)
      raise exception if log_exceptions_disabled

      Rails.logger.warn(exception)
      begin
        EventsManager::Settings.event_exception_unchecked = true
        EventException.create!(event_exception_data(event, listener, exception))
      rescue StandardError => e
        Rails.logger.warn(e)
      end
    end

    def event_exception_data(event, listener, exception)
      data = {}
      EVENT_EXCEPTION_ATTRIBUTES.each do |a, p|
        data[a] = begin
          p.call(event, listener, exception)
                  rescue StandardError => e
                    e.to_s
        end
      end
      data
    end

    def listeners(entity, action)
      @listeners ||= {}
      @listeners[entity] ||= {}
      @listeners[entity][action] ||= []
    end
  end
end
