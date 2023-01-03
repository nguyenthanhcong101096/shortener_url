# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortenerUrlCommands::Create do
  let(:user)       { FactoryBot.create :user }
  let(:short_link) { 'Azj3oK' }
  let(:origin_url) { 'http://example.com/abc' }
  let(:params)     { { origin_url: origin_url, custom_short_url: short_link } }

  subject(:command) { described_class.call(user: user, params: params) }

  describe '#call' do
    context 'when create successfully' do
      it 'return success' do
        expect(command).to be_success
        expect(command.result).to eq(short_link)
      end
    end

    context 'when create failiure' do
      context 'when missing param origin_url' do
        let(:params) { { custom_short_url: short_link } }

        it 'return errors' do
          expect(command).to be_failure
          expect(command.errors[:base]).to match_array([:origin_url_is_required])
        end
      end

      context 'when duplicate short_url' do
        let(:hash_id) { ShortenerUrl.get_hash_id(short_link) }

        before { FactoryBot.create :short_url, origin_url: origin_url, hash_id: hash_id, user_id: user.id }

        it 'return errors' do
          expect(command).to be_failure
          expect(command.errors[:base]).to match_array([:short_url_is_duplicate])
        end
      end
    end
  end
end
