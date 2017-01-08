FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:first_name) { |n| "First Name #{n}" }
    sequence(:last_name) { |n| "Last Name #{n}" }
    member_since { Time.now }
    user_type { User::USER_TYPES.sample }
    password { "password" }
  end
end
