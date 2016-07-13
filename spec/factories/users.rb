FactoryGirl.define do
  pw = ('a'..'h').to_a.shuffle.join
  sequence :email do |n|
    "person#{n}@example.com"
  end
  sequence :username do |n|
    "user#{n}"
  end
  factory :user do
    username
    email
    password pw
    password_confirmation pw
  end
end
