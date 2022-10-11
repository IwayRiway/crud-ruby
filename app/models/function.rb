class Function < ApplicationRecord
  belongs_to :menu, optional: true
  has_many :permissions, dependent: :destroy
  # accepts_nested_attributes_for :permissions
end
