class Shop < ApplicationRecord
  has_many :redirects

  validates :name, :token, :remote_id, presence: true, uniqueness: true
end
