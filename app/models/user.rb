class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :first_name, presence: true

  validates :last_name, presence: true

  has_many :projects, dependent: :destroy 
  has_many :categories, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
