class PaymentsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user

	#show all payments of user
	def index
		@payments = @user.payments
	end

	#add new payment
	def new
		@payment = @user.payments.build
	end
	def create
		@payment = @user.payments.build( payment_params )
		if @payment.save
			redirect_to user_url( @user )
		else
			render :action => :new
		end
	end

	#show single payment
	#NO NEED!!
	# def show
	# 	@payment = @user.payments.find( params[:id] )
	# end

	#edit/delete payment
	def edit
		@payment = @user.payments.find( params[:id] )
	end
	def update
		@payment = @user.payments.find( params[:id] )
		if @payment.update( payment_params )
			user_url( @user )
		else
			render :action => :edit
		end
	end
	def destroy
		@payment = @user.payments.find( params[:id] )
		@payment.destroy
		redirect_to user_url( @user )
	end

private
	def find_user
		@user = User.find( params[:user_id] )
	end

	def payment_params
		params.require(:payment).permit(:item, :cost, :date)
	end
end
