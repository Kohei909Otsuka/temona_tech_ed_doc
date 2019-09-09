require "rails_helper"

RSpec.describe "/users", type: :request do

  def base_path
    "/users"
  end

  describe "POST /users" do
    it "returns 201 created when success" do
      post base_path,
        params: {
          name: "kohei",
          email: "kohei@example.com",
          password: "password-00"
        }
      json_hash = JSON.parse(response.body)

      expect(response).to have_http_status :created
      expect(User.count).to eq 1
    end

    it "returns 422 unprocessable_entity when fail" do
      post base_path,
        params: {
          name: "kohei",
          email: "kohei@example.com",
          password: "short"
        }
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
