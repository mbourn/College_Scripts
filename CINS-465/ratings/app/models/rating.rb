class Rating < ActiveRecord::Base

  validates :course, presence: true
  validates :comment, presence: true
  validates :rating, presence: true

  belongs_to :professor

end
