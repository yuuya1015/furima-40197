FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { '試験' }
    first_name_ruby       { 'シケン' }
    last_name             { '太郎' }
    last_name_ruby        { 'タロウ' }
    birthday              { Date.new(2000, 1, 1) }
  end
end
