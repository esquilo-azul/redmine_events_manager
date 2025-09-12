# frozen_string_literal: true

RSpec.describe EventExceptionsController, type: :feature do
  include_context 'with logged user', 'admin' do
    before do
      RedmineEventsManager::Settings.event_exception_unchecked = true
    end

    it { expect(RedmineEventsManager::Settings.event_exception_unchecked).to be_truthy }
    it { expect(::User.current.login).to eq('admin') } # rubocop:disable Style/RedundantConstantBase

    context 'when index is accessed' do
      before { visit '/event_exceptions' }

      it { expect(RedmineEventsManager::Settings.event_exception_unchecked).to be_falsy }
    end
  end
end
