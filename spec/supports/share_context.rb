RSpec.shared_context "with authenticate user" do
  let(:user){ create(:user) }
  let(:token){ JsonWebToken.encode(sub: user.id) }
  let(:headers){ {Authorization: ["Bearer", token].join(" ")} }
end
