class ChangeDefaultInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :coin, :integer, :default => 5
  	change_column :users, :budget_per_day, :string, :default => "300"
  	User.update_all(coin: 5)
  	User.update_all(budget_per_day: '300')
  end
end
