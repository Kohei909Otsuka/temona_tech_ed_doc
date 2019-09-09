require "rails_helper"

RSpec.describe SessionStorage do

  describe "set/get" do
    it "saves data to storage" do
      r = SessionStorage.set("some-key", "some-value")
      expect(r.success?).to eq true
      expect(SessionStorage.get("some-key").data).to eq "some-value"
    end
  end

  describe "rm" do
    it "removes data from storage" do
      SessionStorage.set("some-key", "some-value")
      SessionStorage.rm("some-key")
      expect(SessionStorage.get("some-key").data).to eq nil
    end
  end

end
