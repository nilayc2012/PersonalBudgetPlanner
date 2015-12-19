class UserRegisterController < ApplicationController
  def add_user
		if UserDetail.exists?(:user_name => params[:uname])
			session[ :msg] = "existing"
			redirect_to :back
		else			
			user_details=UserDetail.new( 
			user_name: params[ :uname ],
			first_name: params[ :fname],
			last_name: params[ :lname],
			password: params[ :pwd ]
			)
      user_details.save
			session[ :msg] = "filled"
			redirect_to :back
		end                 
  end

  def new_user
  
  end
end
