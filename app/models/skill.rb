class Skill < ApplicationRecord
  enum name: { 
    javascript: 'javascript', 
    ruby: 'ruby', 
    rails: 'rails',
  }
  has_many :candidates_skills
  has_many :candidates, through: :candidates_skills, primary_key: :candidate_id
end