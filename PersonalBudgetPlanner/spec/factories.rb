FactoryGirl.define do  factory :notification, :class => 'Notifications' do
    notify_string "MyString"
  end

			factory :expensestub do
			eamt 20000
			edesc 'Bus to chennai'
			etype 'Bus Expense'
			start Date.today
			end
			 factory :invalid_expensestub do
				eamt 
				edesc 'Bus to chennai'
				etype 'Bus Expense'
				start Date.today
    end
end 