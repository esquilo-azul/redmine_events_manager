class EventExceptionsController < ApplicationController
  before_action :require_admin
  layout 'admin_active_scaffold'
  before_action :clear_event_exception_unchecked, only: :index

  active_scaffold :event_exception do |conf|
    conf.actions.exclude :create, :update, :delete
    conf.list.columns = [:created_at, :event_entity, :event_action, :listener_class]
    conf.list.sorting = { created_at: :desc }
  end

  private

  def clear_event_exception_unchecked
    EventsManager::Settings.event_exception_unchecked = false if
    EventsManager::Settings.event_exception_unchecked
  end
end
