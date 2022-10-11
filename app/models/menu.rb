class Menu < ApplicationRecord
    has_many :functions, dependent: :destroy
    accepts_nested_attributes_for :functions, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
end
