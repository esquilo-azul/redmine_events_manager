# frozen_string_literal: true

RSpec.describe EventExceptionsController, type: :feature do
  include_context 'with logged user', 'admin' do
    before do
      EventsManager::Settings.event_exception_unchecked = true
    end

    it { expect(EventsManager::Settings.event_exception_unchecked).to be_truthy }
    it { expect(::User.current.login).to eq('admin') }

    context 'when index is accessed' do
      before { visit '/event_exceptions' }

      it { expect(EventsManager::Settings.event_exception_unchecked).to be_falsy }
    end
  end
end
