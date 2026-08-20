class Doi < ActiveRecord::Base

  has_many :urls, dependent: :destroy
  accepts_nested_attributes_for :urls

  validates :name, presence: true
  validates :doi, presence: true

end
