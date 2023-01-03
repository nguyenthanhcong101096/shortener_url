require 'rails_helper'

RSpec.describe '/api/v1/shortener_urls', type: :request do
  let(:short_link) { 'Azj3oK' }
  let(:origin_url) { 'http://example.com/abc' }
  let(:hash_id)    { ShortenerUrl.get_hash_id(short_link) }

  include_context 'authenticate_user'

  describe 'GET /api/v1/decode' do
    let(:params) { { short_url: short_link } }

    before  { FactoryBot.create :short_url, origin_url: origin_url, hash_id: hash_id, user_id: user.id }

    subject { get api_v1_decode_path, params: params, headers: headers }

    context 'when decode short_url successfully' do
      it_behaves_like 'with_response_success'

      it 'return origin_url' do
        is_expected

        expect(JSON.parse(response.body)).to eq({ 'origin_url' => origin_url })
      end
    end

    context 'when missing params short_url' do
      let(:params) { nil }

      it_behaves_like 'with_response_unprocessable_entity'

      it 'return errors' do
        is_expected

        expect(JSON.parse(response.body)).to eq({ 'errors' => ['short_url_is_required'] })
      end
    end

    context 'when user unauthenticate' do
      let(:headers) { nil }
      let(:params)  { nil }

      it_behaves_like 'unauthenticate'
    end
  end

  describe 'GET /api/v1/encode' do
    let(:params) { { origin_url: origin_url, custom_short_url: short_link } }

    subject { post api_v1_encode_path, params: params, headers: headers }

    context 'when create short_url successfully' do
      it_behaves_like 'with_response_success'

      it 'should add new 1 record' do
        expect { subject }.to change(ShortUrl, :count).by(1)
      end
    end

    context 'when short_url is duplicate' do
      before { FactoryBot.create :short_url, origin_url: origin_url, hash_id: hash_id, user_id: user.id }

      it_behaves_like 'with_response_unprocessable_entity'

      it 'return errors' do
        is_expected

        expect(JSON.parse(response.body)).to eq({ 'errors' => ['short_url_is_duplicate'] })
      end
    end

    context 'when missing params origin_url' do
      let(:params) { { custom_short_url: short_link } }

      it_behaves_like 'with_response_unprocessable_entity'

      it 'return errors' do
        is_expected

        expect(JSON.parse(response.body)).to eq({ 'errors' => ['origin_url_is_required'] })
      end
    end
  end
end
