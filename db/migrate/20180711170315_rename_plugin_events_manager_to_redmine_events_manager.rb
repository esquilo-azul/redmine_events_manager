# frozen_string_literal: true

class RenamePluginEventsManagerToRedmineEventsManager < (
    Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  )
  class Settings < ActiveRecord::Base
  end

  def up
    rename_plugin('redmine_events_manager', 'redmine_events_manager')
  end

  def down
    rename_plugin('redmine_events_manager', 'redmine_events_manager')
  end

  private

  def rename_plugin(from, to)
    old_record = Setting.find_by(name: from)
    return if old_record.blank?

    new_record = Setting.find_by(name: to)
    if new_record.present?
      new_value = plugin_setting_value(old_record).value.merge(plugin_setting_value(new_record))
      new_record.update!(value: new_value)
      old_record.destroy!
    else
      old_record.update!(name: to)
    end
  end

  def plugin_setting_value(record)
    if record.value.blank?
      {}.with_indifferent_access
    elsif record.value.is_a?(Hash)
      record.value
    else
      raise "#{record} value is not Hash or blank"
    end
  end
end
