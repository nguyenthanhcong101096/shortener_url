# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortenerUrlCommands::Show do
  let(:short_link) { 'Azj3oK' }
  let(:origin_url) { 'http://example.com/abc' }
  let(:hash_id)    { ShortenerUrl.get_hash_id(short_link) }
  let(:user)       { FactoryBot.create :user }

  subject(:command) { described_class.call(short_url: short_link) }

  describe '#call' do
    context 'when short_link is exists' do
      before { FactoryBot.create :short_url, origin_url: origin_url, hash_id: hash_id, user_id: user.id }

      it 'return success' do
        expect(command).to be_success
        expect(command.result).to eq(origin_url)
      end
    end

    context 'when missing params short_url' do
      let(:short_link) { nil }

      it 'return errors' do
        expect(command).to be_failure
        expect(command.errors[:base]).to match_array([:short_url_is_required])
      end
    end

    context 'when short_link is not_found' do
      it 'return errors' do
        expect(command).to be_failure
        expect(command.errors[:base]).to match_array([:short_url_not_found])
      end
    end
  end
end
