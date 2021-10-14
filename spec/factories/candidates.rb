# frozen_string_literal: true

FactoryBot.define do
  factory :candidate do
    name { 'Oko' }
    email { 'oko.oko@revelo.com.br' }
    birthday { '13-12-1999' }
    cellphone { '40028922' }
    careers { 'frontend' }
  end
end
