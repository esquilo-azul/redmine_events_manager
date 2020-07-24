# frozen_string_literal: true

class CreateListenerOptions < ActiveRecord::Migration
  def change
    create_table :listener_options do |t|
      t.string :listener_class
      t.integer :delay

      t.timestamps null: false
    end
  end
end
