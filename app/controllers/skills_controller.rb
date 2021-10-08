class SkillsController < ApplicationController
  def index
    #render json: Skill.all()
    skill = Skill.all
    render json: SkillSerializer.new(skill)
  end
end
  