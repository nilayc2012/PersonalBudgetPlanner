require 'rails_helper'

RSpec.describe AddnotificationController, type: :controller do

  describe "GET #add_notification" do
    it "returns http success" do
      get :add_notification
      expect(response).to have_http_status(:success)
    end
  end

end
