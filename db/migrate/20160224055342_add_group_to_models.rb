class AddGroupToModels < ActiveRecord::Migration
  def change
  	add_column :users, :all_groups, :text
  	add_column :payments, :group, :string, default: ""
  end
end
