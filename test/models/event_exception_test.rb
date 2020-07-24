# frozen_string_literal: true

require 'test_helper'

class DummyListener
  def initialize(event)
    @event = event
  end

  def to_s
    'dummy_listener_instance'
  end

  def run
    raise 'Dummy failed!' if @event.data.failed
  end
end

class DummyEntity
  attr_reader :failed

  def initialize(failed)
    @failed = failed
  end

  def to_s
    "dummy_entity_instance_#{failed}"
  end

  def id
    1
  end
end

class EventExceptionTest < ActiveSupport::TestCase
  setup do
    EventsManager.log_exceptions_disabled = false
    @event_exception_count_start = EventException.count
    EventsManager.add_listener(DummyEntity, :create, 'DummyListener')
  end

  test 'successful event should not generate event exception' do
    c = @event_exception_count_start
    EventsManager.trigger(DummyEntity, :create, DummyEntity.new(false))
    assert_equal c, EventException.count, EventException.last.inspect
    assert_not EventsManager::Settings.event_exception_unchecked
  end

  test 'failed event should generate event exception' do
    c = @event_exception_count_start
    EventsManager.trigger(DummyEntity, :create, DummyEntity.new(true))
    assert_equal c + 1, EventException.count

    ee = EventException.last
    assert ee
    assert_equal 'DummyEntity', ee.event_entity, 'event_entity'
    assert_equal 'create', ee.event_action, 'event_action'
    assert_equal <<~DATA_CONTENT, ee.event_data, 'event_data'
      --- !ruby/object:DummyEntity
      failed: true
    DATA_CONTENT
    assert_equal 'DummyListener', ee.listener_class, 'listener_class'
    assert_equal 'dummy_listener_instance', ee.listener_instance, 'listener_instance'
    assert_equal 'RuntimeError', ee.exception_class, 'exception_class'
    assert_equal 'Dummy failed!', ee.exception_message, 'exception_message'
    assert ee.exception_stack.present?
    assert EventsManager::Settings.event_exception_unchecked
  end
end
