class UserLoginController < ApplicationController
  
  def auth_user
    user = UserDetail.find_by user_name: params[ :uname ] 
      if user.nil?
        session[ :message ] = "User doesn't exist"
        redirect_to :back
      else
        # if username and password matches then fill details
        if user.user_name == params[ :uname ] && user.password == Digest::SHA2.hexdigest(params[ :pwd ] )
          session[ :uname ] = user.user_name
          session[:status] = "logged"
          redirect_to "/user_profile/home_page"
        else
          session[ :message ] = "wrong password"
          redirect_to :back   
        end
    end     
  end
  #This method change existing password and validate it
  def change_pwd
    if UserDetail.exists?(:password => Digest::SHA2.hexdigest(params[:currentpwd]))
      if (Digest::SHA2.hexdigest(params[:newpwd]) == Digest::SHA2.hexdigest(params[:confirmnewpwd]))
        user=UserDetail.find_by_user_name(session[:uname])
        user.password = params[:newpwd]
        user.save 
        session[ :msg] = "changed"                  
      else
        session[ :msg] = "not match"        
      end
    else
      #Incorrecr current password
      session[ :msg] = "incorrect"
    end
      redirect_to :back
  end
end