class AddQuantToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :quant, :integer
  end
end
