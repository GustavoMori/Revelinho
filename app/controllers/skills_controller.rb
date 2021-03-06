# frozen_string_literal: true

class SkillsController < ApplicationController
  def index
    skill = Skill.all
    render json: SkillSerializer.new(skill)
  end
end
