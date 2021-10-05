describe CandidatesSkill do
  describe 'Association with skills' do
    it 'Can be associated with skills' do
      skill = Skill.create(name: 'ruby')
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br', skills: [skill])

      expect(candidate.skills).to eq([skill])
    end
  end
  
  describe 'Association with candidate' do
    it 'Can be associated with candidates' do
      skill = Skill.create(name: 'ruby')
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br', skills: [skill])

      expect(skill.candidates).to eq([candidate])
    end
  end
end