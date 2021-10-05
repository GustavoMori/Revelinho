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
end