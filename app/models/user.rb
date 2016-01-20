class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ROLE_STUDENT = 'student'.freeze
  ROLE_STAFF = 'staff'.freeze
  ROLE_ADMIN = 'admin'.freeze

  field :email, type: String
  field :role, type: String

  validates_presence_of :email, :role
  validates_inclusion_of :role, in: [ROLE_STUDENT, ROLE_STAFF, ROLE_ADMIN]

  has_many :proposals
  has_many :votes
end
