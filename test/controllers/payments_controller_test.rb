require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
	include Devise::TestHelpers

	setup :init_a_user

	test "create a payment for someone" do
		p = Payment.count
		post :create, :user_id => @a_user.id, payment: {item: "NewItem", cost: "500"}
		
		assert_equal p + 1, Payment.count
		assert_redirected_to user_path( @a_user )
	end

	test "update current payment" do
		patch :update, :user_id => @a_user.id, :id => @a_payment.id, payment: {item: "NewItem", cost:"100"}
		assert_redirected_to user_path( @a_user )

		# get :edit, :user_id => @a_user.id, :id => @a_payment.id
		# assert_response :success
	end

  private
    def init_a_user
    	@a_user = users( :one )
    	@a_payment = payments( :one )
    	sign_in users( :one )
    end
end
