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
    candidates_skill = CandidatesSkill.find_by(id: params[:id])
    return render status: :not_found if candidates_skill.blank?

    if candidates_skill.destroy
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
