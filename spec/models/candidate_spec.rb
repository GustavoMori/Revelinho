# frozen_string_literal: true

describe Candidate do
  subject { build(:candidate) }

  describe 'When create a candidate, validate the emails is obligated' do
    it 'return true if email is valid' do
      expect(subject).to be_valid
    end

    it 'return false if email is invalid' do
      subject.email = nil
      expect(subject).not_to be_valid
    end
  end

  describe '#skills' do
    it 'Can be associated with skills' do
      skill = create(:skill)
      subject.skills = [skill]

      expect(subject.skills).to eq([skill])
    end
  end

  describe '#candidates_skills' do
    it 'Can associate candidates and skill' do
      subject.save
      skill = create(:skill)
      candidates_skills = create(:candidates_skill, candidate_id: subject.id, skill_id: skill.id)

      expect(subject.candidates_skills).to eq([candidates_skills])
    end
  end

  describe '#careers' do
    it 'verify that fullstack is a valid career' do
      subject.careers = 'fullstack'
      subject.save!

      expect(subject.careers).to eq('fullstack')
    end

    it 'verify that frontend is a valid career' do
      subject.careers = 'frontend'
      subject.save!

      expect(subject.careers).to eq('frontend')
    end

    it 'verify that backend is a valid career' do
      subject.careers = 'backend'
      subject.save!

      expect(subject.careers).to eq('backend')
    end
  end

  describe '#save' do
    context 'When email is not unique' do
      it 'does not save record' do
        create(:candidate, email: 'oko.oko@revelo.com.br')

        expect(subject.save).to be false
      end
    end
  end
end
