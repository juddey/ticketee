class Ticket < ActiveRecord::Base

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state
  has_many :assets
  has_many :comments

  accepts_nested_attributes_for :assets, reject_if: :all_blank

  before_create :assign_default_state

  private
    def assign_default_state
      self.state = State.default
    end

end
