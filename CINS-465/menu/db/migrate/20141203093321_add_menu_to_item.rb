class AddMenuToItem < ActiveRecord::Migration
  def change
    add_column :items, :menu, :integer
  end
end
