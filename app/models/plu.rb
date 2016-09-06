class Plu < ApplicationRecord
  has_many :order_items, dependent: :restrict_with_exception

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
