# frozen_string_literal: true

describe CandidatesSkillSerializer do
  describe '#serializable_hash' do
    it 'return a candidate_skill serialized' do
      javascript = Skill.create(name: 'javascript')
      candidate = Candidate.create(
        name: 'Oko',
        email: 'Oko.oko@revelo.com.br',
        birthday: '01-01-1995',
        cellphone: '40028922',
        careers: 'frontend'
      )

      new_candidate_skill = CandidatesSkill.create(
        skill_id: javascript.id,
        candidate_id: candidate.id
      )

      serialized = CandidatesSkillSerializer.new(new_candidate_skill)
      expect(serialized.serializable_hash).to eq(
        {
          data: {
            id: new_candidate_skill.id,
            type: :candidates_skill,
            relationships: {
              candidate: { data: { id: candidate.id, type: :candidate } },
              skill: { data: { id: javascript.id, type: :skill } }
            }
          }
        }
      )
    end
  end
end
