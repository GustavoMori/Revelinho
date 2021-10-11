# frozen_string_literal: true

describe 'GET /candidates' do
  it 'http status 200' do
    headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
    get '/candidates', headers: headers

    expect(response).to have_http_status(200)
  end

  it 'return list of all candidates' do
    javascript = Skill.create(name: 'javascript')
    candidate = Candidate.create(
      name: 'Oko',
      email: 'oko@oko.com.br',
      cellphone: '40028922',
      careers: 'frontend',
      skills: [javascript]
    )

    headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
    get '/candidates', headers: headers

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json).to eq(
      {
        data: [{
          id: candidate.id,
          type: 'candidate',
          attributes: {
            name: 'Oko',
            email: 'oko@oko.com.br',
            birthday: nil,
            cellphone: '40028922',
            careers: 'frontend'
          },
          relationships: {
            skills: {
              data: [
                {
                  id: javascript.id,
                  type: 'skill'
                }
              ]
            }
          }
        }],
        included: [{
          id: javascript.id,
          type: 'skill',
          attributes: {
            name: 'javascript'
          }
        }]
      }
    )
  end
end

describe 'POST /candidates' do
  context 'When a candidate is submited with all attributes' do
    subject do
      Candidate.new(
        name: 'Oko',
        email: 'oko.oko@revelo.com.br',
        birthday: '13-12-1999',
        cellphone: '40028922',
        careers: 'frontend'
      )
    end

    it 'http status 200' do
      headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }

      post(
        '/candidates',
        params: {
          candidate: {
            name: subject.name,
            email: subject.email,
            birthday: subject.birthday,
            cellphone: subject.cellphone,
            careers: subject.careers
          }
        },
        headers: headers
      )

      expect(response).to have_http_status(200)
    end

    it 'return true if a candidate was created' do
      headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
      post(
        '/candidates',
        params: {
          candidate: {
            name: subject.name,
            email: subject.email,
            birthday: subject.birthday,
            cellphone: subject.cellphone,
            careers: subject.careers
          }
        },
        headers: headers
      )

      finded_candidate = Candidate.find_by(email: subject.email)
      expect(finded_candidate).to have_attributes(
        name: subject.name,
        email: subject.email,
        birthday: Date.new(1999, 12, 13),
        cellphone: subject.cellphone,
        careers: subject.careers
      )
    end

    it 'return Internal Server Error(422)' do
      Candidate.create(
        name: 'Oko',
        email: 'oko.oko@revelo.com.br',
        birthday: '13-12-1999',
        cellphone: '40028922',
        careers: 'frontend'
      )
      candidate_already_exists = Candidate.new(
        name: 'Oko',
        email: 'oko.oko@revelo.com.br',
        birthday: '13-12-1999',
        cellphone: '40028922',
        careers: 'frontend'
      )

      headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
      post(
        '/candidates',
        params: {
          candidate: {
            name: candidate_already_exists.name,
            birthday: candidate_already_exists.birthday,
            email: candidate_already_exists.email,
            cellphone: candidate_already_exists.cellphone,
            careers: candidate_already_exists.careers
          }
        },
        headers: headers
      )

      expect(response).to have_http_status(422)
    end
  end

  context 'When a candidate is submited incompleted' do
    subject do
      Candidate.new(
        name: 'Oko',
        email: 'oko.oko@revelo.com.br',
        birthday: '13-12-1999',
        cellphone: '40028922',
        careers: 'frontend'
      )
    end

    context 'Without email' do
      it 'return a unprocessable entity (422)' do
        headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
        post(
          '/candidates',
          params: {
            candidate: {
              name: subject.name,
              birthday: subject.birthday,
              cellphone: subject.cellphone,
              careers: subject.careers
            }
          },
          headers: headers
        )

        expect(response).to have_http_status(422)
      end
    end

    context 'Without attribute != email' do
      it 'return Internal Server Error' do
        headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
        post(
          '/candidates',
          params: {
            candidate: {
              birthday: subject.birthday,
              email: subject.email,
              cellphone: subject.cellphone,
              careers: subject.careers
            }
          },
          headers: headers
        )

        expect(response).to have_http_status(200)
      end
    end
  end
end

describe 'PATCH /candidates/:id' do
  context 'When a candidate is submited with all attributes' do
    subject do
      Candidate.create(
        name: 'Oko',
        email: 'oko.oko@revelo.com.br',
        birthday: '13-12-1999',
        cellphone: '40028922',
        careers: 'frontend'
      )
    end

    context 'When id is correct' do
      it 'http status 200' do
        updated_subject = Candidate.new(
          name: 'CarrEiras',
          email: 'CarrEiras@CarrEiras.com.br',
          birthday: '13-12-2003',
          cellphone: '40028930',
          careers: 'fullstack'
        )

        headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
        patch(
          "/candidates/#{subject.id}",
          params: {
            candidate: {
              name: updated_subject.name,
              email: updated_subject.email,
              birthday: updated_subject.birthday,
              cellphone: updated_subject.cellphone,
              careers: updated_subject.careers
            }
          },
          headers: headers
        )

        expect(response).to have_http_status(200)
      end

      it 'return candidate updated' do
        updated_subject = Candidate.new(
          name: 'CarrEiras',
          email: 'CarrEiras@CarrEiras.com.br',
          birthday: '13-12-1999',
          cellphone: '40028930',
          careers: 'fullstack'
        )

        headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
        patch(
          "/candidates/#{subject.id}",
          params: {
            candidate: {
              name: updated_subject.name,
              email: updated_subject.email,
              birthday: updated_subject.birthday,
              cellphone: updated_subject.cellphone,
              careers: updated_subject.careers
            }
          },
          headers: headers
        )
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(json).to eq(
          {
            data: {
              id: subject.id,
              type: 'candidate',
              attributes: {
                name: 'CarrEiras',
                email: 'CarrEiras@CarrEiras.com.br',
                birthday: '1999-12-13',
                cellphone: '40028930',
                careers: 'fullstack'
              },
              relationships: {
                skills: {
                  data: []
                }
              }
            }
          }
        )
      end
    end

    context 'When id is not exists' do
      it 'http status 404' do
        update_subject = Candidate.new(
          name: 'CarrEiras',
          email: 'CarrEiras@CarrEiras.com.br',
          birthday: '13-12-2003',
          cellphone: '40028930',
          careers: 'fullstack'
        )

        headers = { 'Authentication-Token': ENV['AUTHENTICATION_TOKEN'] }
        patch(
          '/candidates/1111',
          params: {
            candidate: {
              name: update_subject.name,
              email: update_subject.email,
              birthday: update_subject.birthday,
              cellphone: update_subject.cellphone,
              careers: update_subject.careers
            }
          },
          headers: headers
        )

        expect(response).to have_http_status(404)
      end
    end
  end
end
