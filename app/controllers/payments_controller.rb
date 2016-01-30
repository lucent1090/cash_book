class PaymentsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user

	#show all payments of user
	def index
		@payments = @user.payments.order("date desc").page( params[:page] ).per(10)
	end

	#add new payment
	def new
		@payment = @user.payments.build
	end
	def create
		@payment = @user.payments.build( payment_params )
		if @payment.save
			redirect_to user_path( @user )
		else
			render :action => :new
		end
	end

	#edit/delete payment
	def edit
		@payment = Payment.find( params[:id] )
	end
	def update
		@payment = Payment.find( params[:id] )
		if @payment.update( payment_params )
			redirect_to user_path( @user )
		else
			render :action => :edit
		end
	end
	def destroy
		@payment = Payment.find( params[:id] )
		@payment.destroy
		redirect_to user_path( @user )
	end

private

	def find_user
		@user = User.find( current_user.id )
	end

	def payment_params
		params.require(:payment).permit(:item, :cost, :date)
	end
end
