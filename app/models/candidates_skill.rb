# frozen_string_literal: true

class CandidatesSkill < ApplicationRecord
  belongs_to :candidate
  belongs_to :skill
end
