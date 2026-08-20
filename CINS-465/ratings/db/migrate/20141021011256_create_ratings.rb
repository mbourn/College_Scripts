class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :course
      t.string :comment
      t.integer :rating
      t.references :professor, index: true

      t.timestamps
    end
  end
end
