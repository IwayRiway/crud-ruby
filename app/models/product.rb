class Product < ApplicationRecord
    has_many :product_receiving_items, dependent: :destroy
    # enum status: [:suspend, :active], default: :suspend
     enum :status, { Suspend: 0, Active: 1}, default: :Suspend
end
