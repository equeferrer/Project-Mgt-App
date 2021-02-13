class Task < ApplicationRecord
  validates :name, presence:true
  validates :priority_level, presence:true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }

  belongs_to :category
end