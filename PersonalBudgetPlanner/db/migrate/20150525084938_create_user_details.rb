class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
		t.string :user_name
		t.string :first_name
		t.string :last_name
		t.string :password

		t.timestamps
    end
  end
end
