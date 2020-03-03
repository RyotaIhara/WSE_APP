class Event < ApplicationRecord
  belongs_to :user
  has_many :participants

  mount_uploader :image, ImageUploader
end
