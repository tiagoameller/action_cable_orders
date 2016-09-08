class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :plu

  validates :plu, presence: true

  after_initialize do |r|
    r.units = 1 if new_record? && r.units.nil?
  end

  def total
    return 0 unless plu.present?
    plu.price * units
  end
end
