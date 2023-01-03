RSpec.shared_context "authenticate_user" do
  let!(:user)    { FactoryBot.create :user }
  let!(:token)   { JsonWebToken.encode(sub: user.id) }
  let!(:headers) { {'Authorization': ["Bearer", token].join(" ")} }
end
