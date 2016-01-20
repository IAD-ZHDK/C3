class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :role, type: String, default: 'user'

  validates_presence_of :email, :role
  validates_inclusion_of :role, in: %w(user admin)

  has_many :requested_clinics, class_name: 'Clinic', inverse_of: :requester
  has_many :proposed_clinics, class_name: 'Clinic', inverse_of: :proposer
  has_many :votes
  has_many :attendances

  def admin?
    role == 'admin'
  end

  def votable?(clinic)
    votes.where(clinic_id: clinic.id).empty?
  end

  def attendable?(clinic)
    attendances.where(clinic_id: clinic.id).empty?
  end
end
