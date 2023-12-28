FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'test000000'}
    password_confirmation {password}
    first_name            {'試験'}
    first_name_ruby       {'シケン'}
    last_name             {'太郎'}
    last_name_ruby        {'タロウ'}
    birthday              {Date.new(2000, 1, 1) }
  end
end