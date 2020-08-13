# frozen_string_literal: true

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

RSpec.describe EventException do
  let(:event_exception_count_start) { described_class.count }

  before do
    EventsManager.log_exceptions_disabled = false
    event_exception_count_start
    EventsManager.add_listener(DummyEntity, :create, 'DummyListener')
  end

  context 'when event triggered is successful' do
    before do
      EventsManager.trigger(DummyEntity, :create, DummyEntity.new(false))
    end

    it 'successful event should not generate event exception' do
      expect(described_class.count).to eq(event_exception_count_start)
    end

    it { expect(EventsManager::Settings.event_exception_unchecked).to be_falsy }
  end

  context 'when event triggered is fail' do
    let(:ee) { described_class.last }

    before do
      EventsManager.trigger(DummyEntity, :create, DummyEntity.new(true))
    end

    it 'failed event should generate event exception' do
      expect(described_class.count).to eq(event_exception_count_start + 1)
    end

    it { expect(ee).to be_truthy }
    it { expect(ee.event_entity).to eq('DummyEntity') }
    it { expect(ee.event_action).to eq('create') }
    it { expect(ee.event_data).to eq(<<~DATA_CONTENT) }
      --- !ruby/object:DummyEntity
      failed: true
    DATA_CONTENT
    it { expect(ee.listener_class).to eq('DummyListener') }
    it { expect(ee.listener_instance).to eq('dummy_listener_instance') }
    it { expect(ee.exception_class).to eq('RuntimeError') }
    it { expect(ee.exception_message).to eq('Dummy failed!') }
    it { expect(ee.exception_stack).to be_present }
    it { expect(EventsManager::Settings.event_exception_unchecked).to be_truthy }
  end
end
