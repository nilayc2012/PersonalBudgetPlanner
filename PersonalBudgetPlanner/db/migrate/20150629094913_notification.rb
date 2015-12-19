class Notification < ActiveRecord::Migration
  def change
  	add_column  :notifications, :date1, :date
  end
end
