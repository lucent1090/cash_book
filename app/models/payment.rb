class Payment < ActiveRecord::Base
	validates  :cost, presence: true
	
	belongs_to :user
end
