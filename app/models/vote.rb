class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  include GlobalID::Identification

  belongs_to :user
  belongs_to :clinic
end
