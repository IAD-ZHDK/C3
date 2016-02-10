class Clinic
  include Mongoid::Document
  include Mongoid::Timestamps
  include GlobalID::Identification

  field :title, type: String
  field :description, type: String
  validates_presence_of :title, :description

  belongs_to :requester, class_name: 'User', inverse_of: :requested_clinics
  field :requested_at, type: Time
  validates_presence_of :requester, if: :requested_at

  belongs_to :proposer, class_name: 'User', inverse_of: :proposed_clinics
  field :proposed_at, type: Time
  field :required_votes, type: Integer, default: 10
  validates_presence_of :proposer, if: :proposed_at

  field :appointment, type: Time
  field :scheduled_at, type: Time
  validates_presence_of :appointment, if: :scheduled_at

  has_many :votes
  has_many :confirmations
  has_many :comments

  scope :requested, -> { where(
    :requested_at.exists => true,
    :proposed_at.exists => false,
    :scheduled_at.exists => false
  ) }

  scope :proposed, -> { where(
    :proposed_at.exists => true,
    :scheduled_at.exists => false
  ) }

  scope :scheduled, -> { where(
    :scheduled_at.exists => true,
    :appointment.gte => Time.now
  ) }

  scope :conducted, -> { where(
    :scheduled_at.exists => true,
    :appointment.lt => Time.now
  ) }

  def requested?
    requested_at.present? && proposed_at.blank? && scheduled_at.blank?
  end

  def proposed?
    proposed_at.present? && scheduled_at.blank?
  end

  def scheduled?
    scheduled_at.present? && appointment >= Time.now
  end

  def conducted?
    scheduled_at.present? && appointment < Time.now
  end

  def confirmable?
    scheduled?
  end

  def votable?
    requested? || proposed?
  end
end
