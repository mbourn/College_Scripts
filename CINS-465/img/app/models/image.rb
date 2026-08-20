class Image < ActiveRecord::Base
  belongs_to :user
  has_many :tags, dependent: :destroy
  has_many :imageusers
  has_many :users, through: :imageusers
end
