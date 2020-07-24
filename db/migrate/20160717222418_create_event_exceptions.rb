# frozen_string_literal: true

class CreateEventExceptions < ActiveRecord::Migration
  def change
    create_table :event_exceptions do |t|
      t.string :event_entity
      t.string :event_action
      t.text :event_data
      t.string :listener_class
      t.string :listener_instance
      t.string :exception_class
      t.string :exception_message
      t.text :exception_stack

      t.timestamps null: false
    end
  end
end
