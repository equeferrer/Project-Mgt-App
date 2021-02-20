class Project < ApplicationRecord
  validates :name, presence:true

  has_many :categories, dependent: :destroy
  belongs_to :user 
end
