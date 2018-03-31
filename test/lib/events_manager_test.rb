require 'test_helper'

class EventsManagerTest < ActiveSupport::TestCase
  class StubEntity
  end

  class StubListener
  end

  setup do
    ::EventsManager.add_listener(StubEntity, 'create', StubListener)
    ::EventsManager.add_listener(StubEntity, 'update', StubListener)
  end

  test 'all listeners' do
    y = ::EventsManager.all_listeners
    assert y.is_a?(Array)
    assert y.count > 0
    y.each { |l| assert l.is_a?(String), "#{l}|#{l.class}" }
    assert_equal y.count, y.uniq.count
  end
end
