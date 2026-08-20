class CreateHighScores < ActiveRecord::Migration
  def change
    create_table :high_scores do |t|
      t.string :user
      t.string :game
      t.integer :score
    end
  end
end
