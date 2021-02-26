class Task < ApplicationRecord
  validates :name, presence:true, length: { maximum: 100 }

  validates :priority_level, presence:true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }

  belongs_to :category
  belongs_to :user

  scope :priority, -> { where("completed = false and due_date <= '#{Date.today}'") }


  PRIORITY_OPTIONS = [    
    [' ', '4'],
		['Urgent', '1'],
		['Medium', '2'],
		['Low', '3']
  ]

  def priority_color
    case priority_level
    when 1
      'red'
    when 2
      'yellow'
    when 3
      'gray'
    when 4
      'hidden'
    end
  end  
end