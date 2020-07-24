# frozen_string_literal: true

class AddEnabledToListenerOptions < (
    Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  )
  def change
    add_column :listener_options, :enabled, :boolean, null: false, default: true
  end
end
