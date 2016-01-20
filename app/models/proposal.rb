class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  validates_presence_of :title, :description

  belongs_to :user
  has_many :votes
end
