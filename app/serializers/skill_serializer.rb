# frozen_string_literal: true

class SkillSerializer
  include JSONAPI::Serializer

  # set_type :movie  # optional
  # set_id :owner_id # optional
  attributes :name
  # has_many :candidates_skills
  # belongs_to :candidates
  # belongs_to :movie_type
end
