# frozen_string_literal: true

describe 'POST /candidates_skills' do
  it 'http status 200' do
    rails = Skill.create(name: 'rails')
    candidate = Candidate.create(
      name: 'Okomura',
      email: 'Rin.Okomura@revelo.com.br',
      birthday: '13-12-1999',
      cellphone: '40028922',
      careers: 'frontend',
      skills: []
    )
    headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }

    post(
      '/candidates_skills',
      params: {
        candidates_skill: {
          candidate_id: candidate.id,
          skill_id: rails.id
        }
      },
      headers: headers
    )

    expect(response).to have_http_status(200)
  end

  it 'return true if a candidates_skill was created' do
    rails = Skill.create(name: 'rails')
    candidate = Candidate.create(
      name: 'Okomura',
      email: 'Rin.Okomura@revelo.com.br',
      birthday: '13-12-1999',
      cellphone: '40028922',
      careers: 'frontend',
      skills: []
    )
    headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
    post(
      '/candidates_skills',
      params: {
        candidates_skill: {
          candidate_id: candidate.id,
          skill_id: rails.id
        }
      },
      headers: headers
    )

    finded_candidates_skill = CandidatesSkill.find_by(candidate_id: candidate.id)
    expect(finded_candidates_skill).to have_attributes(
      candidate_id: candidate.id,
      skill_id: rails.id
    )
  end

  it 'return Internal Server Error(422)' do
    rails = Skill.create(name: 'rails')
    candidate = Candidate.create(
      name: 'Oko',
      email: 'oko.oko@revelo.com.br',
      birthday: '13-12-1999',
      cellphone: '40028922',
      careers: 'frontend',
      skills: []
    )
    CandidatesSkill.create(
      candidate_id: candidate.id,
      skill_id: rails.id
    )
    candidates_skill_already_exist = CandidatesSkill.new(
      candidate_id: candidate.id,
      skill_id: rails.id
    )

    headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
    post(
      '/candidates_skills',
      params: {
        candidates_skill: {
          candidate_id: candidates_skill_already_exist.id,
          skill_id: candidates_skill_already_exist.id
        }
      },
      headers: headers
    )

    expect(response).to have_http_status(422)
  end

  it 'return a candidate skill serialized' do
    rails = Skill.create(name: 'rails')
    candidate = Candidate.create(
      name: 'Okomura',
      email: 'Rin.Okomura@revelo.com.br',
      birthday: '13-12-1999',
      cellphone: '40028922',
      careers: 'frontend',
      skills: []
    )

    headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
    post(
      '/candidates_skills',
      params: {
        candidates_skill: {
          candidate_id: candidate.id,
          skill_id: rails.id
        }
      },
      headers: headers
    )

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json).to eq(
      {
        data: {
          id: CandidatesSkill.find_by(candidate_id: candidate.id, skill_id: rails.id).id,
          type: 'candidates_skill',
          relationships: {
            candidate: { data: { id: candidate.id, type: 'candidate' } },
            skill: { data: { id: rails.id, type: 'skill' } }
          }
        }
      }
    )
  end
end

describe 'DELETE /candidates_skills/:id' do
  context 'When id exists' do
    it 'return status 204' do
      rails = Skill.create(name: 'rails')
      candidate = Candidate.create(
        name: 'Okomura',
        email: 'Rin.Okomura@revelo.com.br',
        birthday: '13-12-1999',
        cellphone: '40028922',
        careers: 'frontend',
        skills: []
      )
      candidates_skills = CandidatesSkill.create(
        candidate_id: candidate.id,
        skill_id: rails.id
      )

      headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
      delete(
        "/candidates_skills/#{candidates_skills.id}",
        headers: headers
      )

      expect(response).to have_http_status(204)
    end

    it 'verify if candidate_skill was deleted on DB' do
      rails = Skill.create(name: 'rails')
      candidate = Candidate.create(
        name: 'Okomura',
        email: 'Rin.Okomura@revelo.com.br',
        birthday: '13-12-1999',
        cellphone: '40028922',
        careers: 'frontend',
        skills: []
      )
      candidates_skills = CandidatesSkill.create(
        candidate_id: candidate.id,
        skill_id: rails.id
      )

      headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
      delete(
        "/candidates_skills/#{candidates_skills.id}",
        headers: headers
      )

      expect(CandidatesSkill.find_by(id: candidates_skills.id)).to be_nil
    end
  end

  context 'When id does not exists' do
    it 'http status 404' do
      headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
      delete(
        '/candidates_skills/1111',
        headers: headers
      )

      expect(response).to have_http_status(404)
    end
  end
end
