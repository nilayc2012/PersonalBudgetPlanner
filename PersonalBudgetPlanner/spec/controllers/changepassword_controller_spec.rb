require 'rails_helper'

RSpec.describe ChangepasswordController, type: :controller do

  describe "GET #change_password" do
    it "returns http success" do
      get :change_password
      expect(response).to have_http_status(:success)
    end
  end

end
