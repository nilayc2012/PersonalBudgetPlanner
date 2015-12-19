class UserDetail < ActiveRecord::Base
  has_many :expenses
  devise :omniauthable
  before_save :encrypt_password

  def encrypt_password
    self.password=Digest::SHA2.hexdigest(password)
  end 
   
end
