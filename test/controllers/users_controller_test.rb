require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	include Devise::TestHelpers

	setup :init_a_user

  private
    def init_a_user
    	@a_user = users( :one )
    	sign_in users( :one )
    end
end
