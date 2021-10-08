# frozen_string_literal: true

describe Skill do
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

  describe 'Names validations' do
    context 'When create a skill without name' do
      it 'is invalid' do
        skill = Skill.new(name: nil)
        expect(skill).not_to be_valid
      end
    end

    it 'allow ruby as a name' do
      skill = Skill.new(name: 'ruby')
      expect(skill).to be_valid
    end

    it 'allow rails as a name' do
      skill = Skill.create name: 'rails'
      expect(skill).to be_valid
    end

    it 'allow javascript as a name' do
      skill = Skill.create name: 'javascript'
      expect(skill).to be_valid
    end
  end
end
