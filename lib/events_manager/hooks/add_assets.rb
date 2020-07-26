module EventsManager
  module Hooks
    class AddAssets < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(_context = {})
        stylesheet_link_tag(:application, plugin: 'redmine_events_manager') + "\n"
      end
    end
  end
end
