class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|     
      t.string :notify_string
      t.timestamps
      
end
change_table(:notifications) do |t|
  t.column :date, :date, limit: 60
    end
  end
end
