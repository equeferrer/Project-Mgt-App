class Category < ApplicationRecord
  validates :title, presence:true, length: { maximum: 35 }
  belongs_to :project 
  belongs_to :user
  has_many :tasks, dependent: :destroy
end
