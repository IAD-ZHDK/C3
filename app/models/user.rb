class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :role, type: String

  validates_presence_of :email, :role
  validates_inclusion_of :role, in: %w(admin tutor representative student)

  has_many :proposals
  has_many :votes
end
