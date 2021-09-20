class CandidateSerializer
  include JSONAPI::Serializer

  #set_type :movie  # optional
  #set_id :owner_id # optional
  attributes :name, :email, :birthday, :cellphone, :careers
  has_many :skills
  #belongs_to :owner, record_type: :user
  #belongs_to :movie_type
end