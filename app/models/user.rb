class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :payments
  serialize :all_groups, Array
  before_create :set_default_groups

  attr_accessor :add_new_group
  attr_accessor :delete_group

  private
  def set_default_groups
  	self.all_groups << "food" << "shopping" << "dailyuse"
  end
end
