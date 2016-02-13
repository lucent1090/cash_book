class AddColunmToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :coin, :integer
  	add_column :users, :budget_per_day, :string
  end
end
