class CreateSharedExpenses < ActiveRecord::Migration
  def change
    create_table :shared_expenses do |t|
	 t.integer :expense_id
      t.string :expense_type
      t.decimal :expense_amount
      t.date :expense_date
      t.text :expense_desc
      t.string :user_name
      t.string :shared_user_name

      t.timestamps
    end
  end
end
