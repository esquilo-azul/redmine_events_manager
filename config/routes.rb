# frozen_string_literal: true

RedmineApp::Application.routes.draw do
  concern :active_scaffold, ActiveScaffold::Routing::Basic.new(association: true)
  resources(:event_exceptions, concerns: :active_scaffold) do
    member do
      get :download
    end
  end
  resources(:listener_options, concerns: :active_scaffold)
end
