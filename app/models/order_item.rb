class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :plu

  validates :plu, presence: true
end
