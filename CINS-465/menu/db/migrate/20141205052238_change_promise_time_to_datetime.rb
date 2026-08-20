class ChangePromiseTimeToDatetime < ActiveRecord::Migration
  def change
    change_column :orders, :promise_time, :datetime
  end
end
