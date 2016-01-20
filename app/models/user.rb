class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :role, type: String, default: 'user'

  validates_presence_of :email, :role
  validates_inclusion_of :role, in: %w(user admin)

  has_many :requests, class_name: 'Clinic', inverse_of: :requester
  has_many :propositions, class_name: 'Clinic', inverse_of: :proposer

  def admin?
    self.role == 'admin'
  end
end
