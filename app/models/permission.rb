class Permission < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :function, optional: true
  accepts_nested_attributes_for :function
end
