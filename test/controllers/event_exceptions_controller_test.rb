# frozen_string_literal: true

require 'test_helper'

class EventExceptionsControllerTest < ActionController::TestCase
  fixtures :users

  def setup
    User.current
    @request.session[:user_id] = 1 # admin
  end

  test 'access index should clear event exception unchecked' do
    EventsManager::Settings.event_exception_unchecked = true
    get :index
    assert_response :success
    assert_not EventsManager::Settings.event_exception_unchecked
  end
end
