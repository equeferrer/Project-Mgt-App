class Category < ApplicationRecord
  validates :title, presence:true
  belongs_to :project 
  belongs_to :user
  has_many :tasks, dependent: :destroy
end
