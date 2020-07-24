# frozen_string_literal: true

class EventException < ActiveRecord::Base
  self.inheritance_column = nil

  validates :event_entity, :event_action, :event_data, :listener_class, :listener_instance,
            :exception_class, :exception_message, :exception_stack, presence: true
end
