class Url < ActiveRecord::Base

  belongs_to :doi

  # validates :url, presence: true
end
