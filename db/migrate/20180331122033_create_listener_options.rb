# frozen_string_literal: true

class CreateListenerOptions < (
    Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  )
  def change
    create_table :listener_options do |t|
      t.string :listener_class
      t.integer :delay

      t.timestamps null: false
    end
  end
end
