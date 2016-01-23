class UsersController < ApplicationController
	before_action :authenticate_user!, except: :index
	before_action :set_user, only: :show

	#root page
	def index
	end

	#show personal profile
	def show
		@payments = @user.payments.where("DATE(date) = ?", Date.today)
		@today_sum = @user.payments.where("DATE(date) = ?", Date.today).sum :cost
		@yesterday_sum = @user.payments.where("DATE(date) = ?", Date.yesterday).sum :cost
	end

  private
  	def set_user
  		@user = User.find( params[:id] )
  	end
end
