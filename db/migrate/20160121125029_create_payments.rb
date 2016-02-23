class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :item
      t.string :cost
      t.datetime :date
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
