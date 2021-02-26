class Project < ApplicationRecord
  validates :name, presence:true, length: { maximum: 40 }

  has_many :categories, dependent: :destroy
  belongs_to :user 
end
