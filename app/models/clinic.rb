class Clinic
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  belongs_to :requester, class_name: 'User', inverse_of: :requested_clinics
  field :requested_at, type: Time

  belongs_to :proposer, class_name: 'User', inverse_of: :proposed_clinics
  field :proposed_at, type: Time
  field :required_votes, type: Integer, default: 10

  field :appointment, type: Time
  field :scheduled_at, type: Time

  has_many :votes
  has_many :attendances

  validates_presence_of :title, :description
  validates_presence_of :requested_at, if: :requester
  validates_presence_of :proposed_at, if: :proposer
  validates_presence_of :required_votes, if: :proposer
  validates_presence_of :scheduled_at, if: :appointment

  scope :requested, -> { where(
    :requester.exists => true,
    :proposer.exists => false,
    :appointment.exists => false
  ) }

  scope :proposed, -> { where(
    :proposer.exists => true,
    :appointment.exists => false
  ) }

  scope :scheduled, -> { where(
    :appointment.exists => true,
    :scheduled_at.gte => Time.now
  ) }

  scope :conducted, -> { where(
    :appointment.exists => true,
    :scheduled_at.lt => Time.now
  ) }

  def requested?
    requester.present? && proposer.blank? && appointment.blank?
  end

  def proposed?
    proposer.present? && appointment.blank?
  end

  def scheduled?
    appointment.present? && scheduled_at >= Time.now
  end

  def conducted?
    appointment.present? && scheduled_at < Time.now
  end

  def attendable?
    scheduled?
  end

  def votable?
    requested? || proposed?
  end
end
