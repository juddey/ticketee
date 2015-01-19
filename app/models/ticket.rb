class Ticket < ActiveRecord::Base
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  belongs_to :project
  belongs_to :author, class_name: "User"
  has_many :assets

  accepts_nested_attributes_for :assets, reject_if: :all_blank

end
