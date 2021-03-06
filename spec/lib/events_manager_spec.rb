# frozen_string_literal: true

RSpec.describe(::EventsManager) do
  let(:stub_entity_class) { ::Class.new }
  let(:stub_listener_class) { ::Class.new }

  before do
    described_class.add_listener(stub_entity_class, 'create', stub_listener_class)
    described_class.add_listener(stub_entity_class, 'update', stub_listener_class)
  end

  it { expect(described_class.all_listeners).to be_a(Array) }
  it { expect(described_class.all_listeners.count).to be_positive }
  it { expect(described_class.all_listeners).to(be_all { |l| l.is_a?(::String) }) }
  it { expect(described_class.all_listeners.count).to eq(described_class.all_listeners.uniq.count) }
end
