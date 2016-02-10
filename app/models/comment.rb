class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include GlobalID::Identification

  field :text, type: String

  belongs_to :clinic
  belongs_to :user

  validates_presence_of :text, :clinic_id, :user_id
end
