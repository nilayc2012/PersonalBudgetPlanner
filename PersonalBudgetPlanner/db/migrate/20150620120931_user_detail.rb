class UserDetail < ActiveRecord::Migration
  def change
add_column :user_details, :provider, :string
    add_column :user_details, :uid, :string
    add_column :user_details, :email, :string

  end
end
