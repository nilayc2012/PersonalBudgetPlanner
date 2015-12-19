class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
	t.string :expense_type
      t.decimal :expense_amount
      t.date :expense_date
      t.text :expense_desc
	  t.string :user_name
	  
      t.timestamps
    end
  end
end
