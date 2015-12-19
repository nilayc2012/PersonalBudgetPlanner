class Expense < ActiveRecord::Base
  belongs_to :user_detail
  validates_presence_of :expense_amount
  attr_accessor :from_date , :to_date
end
