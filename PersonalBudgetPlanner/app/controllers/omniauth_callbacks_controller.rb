class OmniauthCallbacksController < Devise::OmniauthCallbacksController   
def twitter
    auth = env["omniauth.auth"]

    @user = UserDetail.find_for_twitter_oauth(request.env["omniauth.auth"],current_user)
    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in_and_redirect user, :event => :authentication
    else
      session["devise.twitter_uid"] = request.env["omniauth.auth"]
      redirect_to "/user_profile/home_page"
    end
  end
end