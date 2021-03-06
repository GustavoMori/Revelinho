# frozen_string_literal: true

describe SkillSerializer do
  describe '#serializable_hash' do
    it 'return a skill serialized' do
      javascript = Skill.create(name: 'javascript')

      serializer = SkillSerializer.new javascript

      expect(serializer.serializable_hash).to eq(
        {
          data: {
            id: javascript.id,
            type: :skill,
            attributes: { name: 'javascript' }
          }
        }
      )
    end
  end
end
