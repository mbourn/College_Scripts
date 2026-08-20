class AddUidToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :uid, :integer
  end
end
