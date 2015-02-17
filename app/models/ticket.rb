class Ticket < ActiveRecord::Base

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state
  has_many :assets
  has_many :comments
  attr_accessor :tag_names
  has_and_belongs_to_many :tags, uniq: true
  has_and_belongs_to_many :watchers, join_table: "ticket_watchers",
                                     class_name: "User"

  accepts_nested_attributes_for :assets, reject_if: :all_blank

  before_create :assign_default_state
  after_create :author_watches_me

  searcher do
    label :tag, from: :tags, field: "name"
    label :state, from: :state, field: "name"
  end

  def tag_names=(names)
    @tag_names = names
    names.split(",").each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end

  private
    def assign_default_state
      self.state = State.default
    end

    def author_watches_me
      if author
        self.watchers << author unless self.watchers.include?(author)
      end
    end

end
