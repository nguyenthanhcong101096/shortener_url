RSpec.shared_examples "unauthenticate" do
  it "conforms to request schema" do
    is_expected
    expect(response).to have_http_status(:unauthorized)
  end
end

RSpec.shared_examples "with_response_success" do
  it "conforms to request schema" do
    is_expected
    expect(response).to have_http_status(:ok)
  end
end

RSpec.shared_examples "with_response_unprocessable_entity" do
  it "conforms to request schema" do
    is_expected
    expect(response).to have_http_status(:unprocessable_entity)
  end
end