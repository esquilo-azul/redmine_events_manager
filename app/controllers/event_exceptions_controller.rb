class EventExceptionsController < ApplicationController
  before_action :require_admin
  layout 'admin_active_scaffold'

  active_scaffold :event_exception do |conf|
    conf.actions.exclude :create, :update, :delete
    conf.list.columns = [:created_at, :event_entity, :event_action, :listener_class]
    conf.list.sorting = { created_at: :desc }
  end
end
