# frozen_string_literal: true

describe CandidatesSkill do
  describe 'Association with skills' do
    it 'Can be associated with skills' do
      skill = Skill.create(name: 'ruby')
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br')
      candidates_skill = CandidatesSkill.create(skill_id: skill.id, candidate_id: candidate.id)

      expect(candidates_skill.skill).to eq(skill)
    end
  end

  describe 'Association with candidate' do
    it 'Can be associated with candidates' do
      skill = Skill.create(name: 'ruby')
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br')
      candidates_skill = CandidatesSkill.create(skill_id: skill.id, candidate_id: candidate.id)

      expect(candidates_skill.candidate).to eq(candidate)
    end
  end

  describe 'When a candidate_skill is created without relationship of candidate or skill' do
    it 'Verify if is persisted without relationship of skill it fails' do
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br')
      candidates_skill = CandidatesSkill.create(skill_id: nil, candidate_id: candidate.id)

      expect(candidates_skill).not_to be_persisted
    end

    it 'Verify if is persisted without relationship of candidate it fails' do
      skill = Skill.create(name: 'ruby')
      candidates_skill = CandidatesSkill.create(skill_id: skill.id, candidate_id: nil)

      expect(candidates_skill).not_to be_persisted
    end
  end
end
