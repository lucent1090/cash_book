class UsersController < ApplicationController
	before_action :authenticate_user!, except: :index
	before_action :set_user, only: [:show, :update_coin]

	#show personal profile
	def show
		@payments = @user.payments.where("DATE(date) = ?", Date.today).order("date desc")
		@today_sum = @user.payments.where("DATE(date) = ?", Date.today).sum :cost
		@yesterday_sum = @user.payments.where("DATE(date) = ?", Date.yesterday).sum :cost
	end

	# ajax call
	def update_coin
		if params[:thecoin]
			@user.coin = params[:thecoin]
			@user.save

			respond_to do |format|
				format.js
			end
		end
		
	end

	def graphic_data
		# [{"text":"study","size":40}, ...]
		@data = []

		item = Payment.pluck(:item)
		cost = Payment.pluck(:cost)

		for index in 0..(item.length-1)
			@data << {"text"=>item[index], "size"=>cost[index].to_i}
		end

		respond_to do |format|
			format.json{
				render :json => @data
			}
		end
	end

  private
  	def set_user
  		@user = User.find( current_user.id )
  	end
end
