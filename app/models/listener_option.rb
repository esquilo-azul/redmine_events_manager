# frozen_string_literal: true

class ListenerOption < ActiveRecord::Base
  DEFAULT_DELAY = 0
  DEFAULT_ENABLED = true

  class << self
    def listener_class_list
      @listener_class_list ||= ::RedmineEventsManager.all_listeners
    end

    def listener_class_options
      listener_class_list.sort.map { |v| [v, v] }
    end

    def listener_delay(listener_class)
      o = ::ListenerOption.find_by(listener_class: listener_class.to_s)
      o && o.delay.present? && o.delay >= 0 ? o.delay : DEFAULT_DELAY
    end

    def listener_enabled?(listener_class)
      o = ::ListenerOption.find_by(listener_class: listener_class.to_s)
      o.present? ? o.enabled? : DEFAULT_ENABLED
    end

    def listener_enable(listener_class, enabled)
      o = ::ListenerOption.find_or_create_by(listener_class: listener_class.to_s)
      o.enabled = enabled
      o.save!
    end
  end

  validates :listener_class, presence: true, uniqueness: true, # rubocop:disable Rails/UniqueValidationWithoutIndex
                             inclusion: { in: listener_class_list }
  validates :delay, allow_blank: true,
                    numericality: { integer_only: true }
end
