describe Skill do
  describe 'When create a skill without name' do
    it 'return NotnullViolation' do
      expect { Skill.create }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end

  describe '#candidates' do
    it 'Can be associated with candidates' do
      skill = Skill.create(name: 'ruby')
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br', skills: [skill])

      expect(skill.candidates).to eq([candidate])
    end
  end

  describe '#candidates_skills' do
    it 'Can associate skill and candidates' do
      candidate = Candidate.create(name: 'Oko', email: 'oko.oko@revelo.com.br')
      skill = Skill.create(name: 'ruby')
      candidates_skills = CandidatesSkill.create(candidate_id: candidate.id, skill: skill)
      
      expect(skill.candidates_skills).to eq([candidates_skills])
    end
  end

  describe '#name' do
    it 'verify that ruby is a valid name' do
      skill = Skill.create name: 'ruby'
      expect(skill.name).to eq('ruby')
    end

    it 'verify that rails is a valid name' do
      skill = Skill.create name: 'rails'
      expect(skill.name).to eq('rails')
    end

    it 'verify that javascript is a valid name' do
      skill = Skill.create name: 'javascript'
      expect(skill.name).to eq('javascript')
    end
  end
end