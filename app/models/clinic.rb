class Clinic
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  field :request, type: String
  field :requested_at, type: Time
  belongs_to :requester, class_name: 'User', inverse_of: :requests

  field :proposal, type: String
  field :proposed_at, type: Time
  belongs_to :proposer, class_name: 'User', inverse_of: :propositions

  field :scheduled_for, type: Time
  field :scheduled_at, type: Time

  field :executed_at, type: Time

  has_many :votes
  has_many :attendances

  scope :requested, -> { where(:request.exists => true) }
  scope :proposed, -> { where(:proposed.exists => true) }
  scope :scheduled, -> { where(:scheduled.exists => true) }
  scope :executed, -> { where(:executed.exists => true) }
end
