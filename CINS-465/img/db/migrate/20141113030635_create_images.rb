class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.boolean :public
      t.references :user, index: true

      t.timestamps
    end
  end
end
