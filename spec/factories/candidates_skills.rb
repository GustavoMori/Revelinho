FactoryBot.define do
  factory :candidates_skill do
    association :skill
    association :candidate
  end
end
