class ProductReceivingItem < ApplicationRecord
  belongs_to :product_receiving, optional: true
  belongs_to :product, optional: true
  enum :status, { Suspend: 0, Active: 1}, default: :Suspend
end
