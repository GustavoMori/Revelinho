# frozen_string_literal: true

class CandidatesSkillsController < ApplicationController
  def create
    new_candidate_skill = CandidatesSkill.new(candidate_skill_params)

    if new_candidate_skill.save
      render json: CandidatesSkillSerializer.new(new_candidate_skill)
    else
      head :unprocessable_entity
    end
  end

  def destroy
    if CandidatesSkill.find(params[:id]).destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def candidate_skill_params
    params.require(:candidates_skill).permit(:candidate_id, :skill_id)
  end
end
