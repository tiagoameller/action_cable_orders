class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :plus, through: :order_items

  validates :name, presence: true

  scope :not_serviced, -> { where('serviced = ?', false) }
end
