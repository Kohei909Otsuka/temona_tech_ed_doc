require "rails_helper"

RSpec.describe User, type: :model do
  let(:valid_user) {build(:user)}

  describe "validation" do

    it "valid_user is valid" do
      expect(valid_user.valid?).to eq true
    end

    it "validates email" do
      existing_user = create(:user, email: "duplicate@example.com")
      user = valid_user

      user.email = ""
      expect(user.valid?).to eq false

      user.email = "duplicate@example.com"
      expect(user.valid?).to eq false
    end
  end

  describe "self.register" do

    let(:name) {"kohei"}
    let(:email) {"kohei@example.com"}

    def check_register(result, success)
      expect(result.success?).to eq success

      if success
        expect(User.find_by(email: email)).not_to eq nil
      else
        expect(User.find_by(email: email)).to eq nil
      end
    end

    it "returns success then saved when nothing wrong" do
      r = described_class.register(name, email, "password-00")
      check_register(r, true)

      pre_caled_hash = Digest::SHA256.hexdigest("password-00")
      hash = User.find_by(email: email).hashed_password
      expect(hash).to eq pre_caled_hash
    end

    it "returns false when password nil or empty" do
      [nil, ""].each do |pass|
        r = described_class.register(name, email, pass)
        check_register(r, false)
      end
    end

    it "returns false when password is too short" do
      r = described_class.register(name, email, "ab-12345")
      check_register(r, false)
    end

    it "returns false when password has no number" do
      r = described_class.register(name, email, "abcd-efgh")
      check_register(r, false)
    end

    it "returns false when password has no char" do
      r = described_class.register(name, email, "1234-5678")
      check_register(r, false)
    end

    it "returns false when password has no symbol" do
      r = described_class.register(name, email, "password00")
      check_register(r, false)
    end

    it "returns false when user has validation err" do
      wrong_format_email = "this_is_not_valid_email"
      r = described_class.register(name, wrong_format_email, "password-00")
      check_register(r, false)
    end
  end

  describe "self.login" do
    before do
      @user = described_class
        .register("kohei", "kohei@example.com", "password-00")
        .data
      allow(SecureRandom).to receive(:uuid)
        .and_return("some-uuid")
    end

    it "returns true when user found" do
      r = described_class.login("kohei@example.com", "password-00")
      expect(r.success?).to eq true
      expect(r.data.id).to eq @user.id
      expect(r.data.session_id).to eq "some-uuid"
    end

    it "returns false when email wrong" do
      r = described_class.login("otsuka@example.com", "password-00")
      expect(r.success?).to eq false
      expect(r.data).to eq nil
    end

    it "returns false when password wrong" do
      r = described_class.login("kohei@example.com", "password-99")
      expect(r.success?).to eq false
      expect(r.data).to eq nil
    end
  end

  describe "#logout" do
    let(:session_id) {"some-session-id"}
    before do
      @user = described_class
        .register("kohei", "kohei@example.com", "password-00")
        .data
      @user.session_id = session_id
      SessionStorage.set(session_id, @user.id)
    end

    it "return true and rm session when key found" do
      r = @user.logout
      expect(r.success?).to eq true
      expect(SessionStorage.get(session_id).data).to eq nil
    end

  end
end
