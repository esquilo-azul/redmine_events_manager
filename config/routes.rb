# frozen_string_literal: true

RedmineApp::Application.routes.draw do
  resources(:event_exceptions) do
    as_routes
    member do
      get :download
    end
  end
  resources(:listener_options) { as_routes }
end
