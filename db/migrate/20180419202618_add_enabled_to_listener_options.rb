class AddEnabledToListenerOptions < ActiveRecord::Migration
  def change
    add_column :listener_options, :enabled, :boolean, null: false, default: true
  end
end
