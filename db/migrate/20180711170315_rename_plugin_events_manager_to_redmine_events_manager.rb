# frozen_string_literal: true

class RenamePluginEventsManagerToRedmineEventsManager < ActiveRecord::Migration
  class Settings < ActiveRecord::Base
  end

  def up
    rename_plugin('events_manager', 'redmine_events_manager')
  end

  def down
    rename_plugin('redmine_events_manager', 'events_manager')
  end

  private

  def rename_plugin(from, to)
    old_record = Setting.find_by(name: from)
    return unless old_record.present?

    new_record = Setting.find_by(name: to)
    if new_record.present?
      new_value = plugin_setting_value(old_record).value.merge(plugin_setting_value(new_record))
      new_record.update_attributes!(value: new_value)
      old_record.destroy!
    else
      old_record.update_attributes!(name: to)
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
