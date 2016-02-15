class AddDefaultToCoin < ActiveRecord::Migration
  def change
  	change_column :users, :coin, :integer, :default => 0
  	change_column :users, :budget_per_day, :string, :default => "0"
  end
end
