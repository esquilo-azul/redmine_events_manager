class ListenerOptionsController < ApplicationController
  before_action :require_admin
  layout 'admin'

  active_scaffold :listener_option do |conf|
    conf.columns[:listener_class].form_ui = :select
    conf.columns[:listener_class].options ||= {}
    conf.columns[:listener_class].options[:options] = ::ListenerOption.listener_class_options
  end
end
