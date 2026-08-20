class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true
      t.references :item, index: true
      t.integer :quant

      t.timestamps
    end
  end
end
