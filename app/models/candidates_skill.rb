class CandidatesSkill < ApplicationRecord
  belongs_to :candidate
  belongs_to :skill
end