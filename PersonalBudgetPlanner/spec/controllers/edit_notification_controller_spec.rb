require 'rails_helper'

RSpec.describe EditNotificationController, type: :controller do

  describe "GET #edit_notify" do
    it "returns http success" do
      get :edit_notify
      expect(response).to have_http_status(:success)
    end
  end

end
