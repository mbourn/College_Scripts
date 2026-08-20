class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :price
      t.string :pic
      t.string :allergy
      t.string :recipe
      t.string :desc
      t.boolean :glut
      t.boolean :veg
      t.boolean :vegan
      t.boolean :kid

      t.timestamps
    end
  end
end
