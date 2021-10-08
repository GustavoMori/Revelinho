describe 'GET /skills' do
  it 'http status 200' do
    get "/skills"

    expect(response).to have_http_status(200)
  end

  it 'return list of all skills' do
    javascript = Skill.create(name: 'javascript')
    ruby = Skill.create(name: 'ruby')
    rails = Skill.create(name: 'rails')

    get "/candidates"

    json = JSON.parse(response.body).deep_symbolize_keys
    {
      data: [
        {
          id: javascript.id,
          type: "skill",
          attributes: {
            name: "javascript"
          }
        },
        {
          id: ruby.id,
          type: "skill",
          attributes: {
            name: "ruby"
          }
        },
        {
          id: rails.id,
          type: "skill",
          attributes: {
            "name": "rails"
          }
        }
      ]
    }
  end
end