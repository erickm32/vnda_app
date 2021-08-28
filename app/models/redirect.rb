class Redirect < ApplicationRecord
  belongs_to :shop

  validates :origin, :destination, presence: true
  validates :origin, uniqueness: { scope: :shop_id }
end
