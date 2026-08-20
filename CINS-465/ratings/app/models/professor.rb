class Professor < ActiveRecord::Base

  has_many :ratings, dependent: :destroy
  accepts_nested_attributes_for :ratings

  validates :first, presence: true
  validates :last, presence: true
  validates :university, presence: true

  def name
    first + ' ' + last
  end

end

