# frozen_string_literal: true

class CandidatesController < ApplicationController
  def index
    candidate = Candidate.all

    render json: CandidateSerializer.new(candidate, include: [:skills])
  end

  def update
    update_candidate = Candidate.find_by(id: params[:id])
    return render status: :not_found if update_candidate.blank?

    if update_candidate.update(candidate_params)
      render json: CandidateSerializer.new(update_candidate)
    else
      head :unprocessable_entity
    end
  end

  def create
    new_candidate = Candidate.new(candidate_params)

    if new_candidate.save
      render json: CandidateSerializer.new(new_candidate)
    else
      head :unprocessable_entity
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :email, :birthday, :cellphone, :careers)
  end
end
