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
		cost = Payment.pluck(:cost).map!{|x| x.to_i}

		# mapping
		tar_big = {max: 40, min: 30}
		tar_small = {max: 30, min: 1}
		ori_big = {max: 0, min: 0}
		ori_small = {max: 0, min: 0}

		# 1. 求平均, max, min
		avg = cost.inject{ |sum, el| sum + el }.to_f / cost.size
		cost.each do |num|
		  if num > avg
		    ori_big[:max] = num if num > ori_big[:max]
		    ori_big[:min] = num if num < ori_big[:min]
		  else
		    ori_small[:max] = num if num > ori_small[:max]
		    ori_small[:min] = num if num < ori_small[:min]
		  end
		end
		# 2. 平均以上一個group, 平均以下另一個, 各組內各自linear mapping
		cost.each_with_index do |num, index|
		  if num >avg
		    cost[index] = linear_mapping(num, ori_big, tar_big)
		  else
		    cost[index] = linear_mapping(num, ori_small, tar_small)
		  end
		end

		# format as word cloud
		for index in 0..(item.length-1)
			@data << {"text"=>item[index], "size"=>cost[index]}
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

  	#linear mapping
		def linear_mapping(num, ori, tar)
		  scale = (num.to_f - ori[:min])/(ori[:max] - ori[:min])
		  return tar[:min] + scale*(tar[:max] - tar[:min])
		end
end
