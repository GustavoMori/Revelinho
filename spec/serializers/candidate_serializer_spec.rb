describe CandidateSerializer do
  describe '#serializable_hash' do
    it 'return a candidate serialized' do
      javascript = Skill.create(name: 'javascript')
      candidate = Candidate.create(name: 'Oko', email: 'Oko.oko@revelo.com.br', birthday: '01-01-1995', cellphone: '40028922', careers: 'frontend', skills: [javascript])

      serializer = CandidateSerializer.new(candidate, include: [:skills])

      expect(serializer.serializable_hash).to eq({
        data: {
          id: candidate.id,
          type: :candidate,
          attributes: {name: candidate.name, email: candidate.email, birthday: candidate.birthday, cellphone: candidate.cellphone, careers: candidate.careers},
          relationships: {skills: {data: [{id: javascript.id, type: :skill}]}}
        },
        included: [
          { id: javascript.id , type: :skill, attributes: {name: javascript.name} }
        ]
      })
    end
  end
end