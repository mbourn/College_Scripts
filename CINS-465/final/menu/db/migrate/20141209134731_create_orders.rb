class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :charge
      t.datetime :promise_time
      t.string :req
      t.integer :uid

      t.timestamps
    end
  end
end
