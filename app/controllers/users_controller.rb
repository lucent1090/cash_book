class UsersController < ApplicationController
	before_action :authenticate_user!, except: :index
	before_action :set_user, only: [:show, :update_coin]

	#root page
	# def index
	# end

	#show personal profile
	def show
		@payments = @user.payments.where("DATE(date) = ?", Date.today).order("date desc")
		@today_sum = @user.payments.where("DATE(date) = ?", Date.today).sum :cost
		@yesterday_sum = @user.payments.where("DATE(date) = ?", Date.yesterday).sum :cost
	end

	def update_coin
		if params[:thecoin]
			@user.coin = params[:thecoin]
			@user.save

			respond_to do |format|
				format.js
			end
		end
		
	end

  private
  	def set_user
  		@user = User.find( current_user.id )
  	end
end
