RedmineApp::Application.routes.draw do
  resources(:event_exceptions) { as_routes }
end
