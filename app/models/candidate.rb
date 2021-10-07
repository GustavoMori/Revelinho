class Candidate < ApplicationRecord
  enum careers: { 
    frontend: 'frontend', 
    backend: 'backend', 
    fullstack: 'fullstack' 
  }
  has_many :candidates_skills
  has_many :skills, through: :candidates_skills, primary_key: :skill_id
  validates :email, presence: true, uniqueness: true
end
