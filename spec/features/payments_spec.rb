require 'rails_helper'

RSpec.feature "Payments", type: :feature do

	scenario "user log in and add a new payment" do
		
		u = create( :user )
		login_as( u )

		p_count = u.payments.count

		visit user_path( u )
		click_link "新增支出"
		
		fill_in "Item", with: "Dinner"
		fill_in "Cost", with: "100"
		click_button "Create Payment"

		expect(current_path).to eq user_path(u)
		expect(u.payments.count).to be (p_count+1)
	end
	
end
