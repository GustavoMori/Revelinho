describe Candidate do
  describe 'When create a candidate, validate the emails is obligated' do
    it 'return true if email is valid' do
      candidate = Candidate.new(name: 'Oko', email: 'oko.oko@revelo.com.br')
      expect(candidate).to be_valid
    end

    it 'return false if email is invalid' do
      candidate = Candidate.new name: 'Oko'
      expect(candidate).not_to be_valid
    end
  end

  describe '#skills' do
    it 'Can be associated with skills' do
      skill = Skill.create(name: 'ruby')
      candidate = Candidate.new(name: 'Oko', email: 'oko.oko@revelo.com.br', skills: [skill])

      expect(candidate.skills).to eq([skill])
    end
  end

  describe '#candidates_skills' do
    it 'Can associate candidates and skill' do
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br')
      skill = Skill.create(name: 'ruby')
      candidates_skills = CandidatesSkill.create(candidate_id: candidate.id, skill: skill)
      
      expect(candidate.candidates_skills).to eq([candidates_skills])
    end
  end

  describe '#careers' do
    it 'verify that fullstack is a valid career' do
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br', careers: 'fullstack')
      
      expect(candidate.careers).to eq('fullstack')
    end

    it 'verify that frontend is a valid career' do
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br', careers: 'frontend')
      
      expect(candidate.careers).to eq('frontend')
    end

    it 'verify that backend is a valid career' do
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br', careers: 'backend')
      
      expect(candidate.careers).to eq('backend')
    end
  end
end