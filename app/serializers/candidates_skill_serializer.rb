# frozen_string_literal: true

class CandidatesSkillSerializer
  include JSONAPI::Serializer

  belongs_to :skill
  belongs_to :candidate
end
