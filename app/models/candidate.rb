# frozen_string_literal: true

class Candidate < ApplicationRecord
  enum careers: {
    frontend: 'frontend',
    backend: 'backend',
    fullstack: 'fullstack'
  }
  has_many :candidates_skills, dependent: :destroy
  has_many :skills, through: :candidates_skills, primary_key: :skill_id, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end
