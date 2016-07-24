RedmineApp::Application.routes.draw do
  resources(:event_exceptions) do
    as_routes
    member do
      get :download
    end
  end
end
