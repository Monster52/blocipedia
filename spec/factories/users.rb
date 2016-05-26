FactoryGirl.define do
  pw = ('a'..'h').to_a.shuffle.join
  factory :user do
    username 'hack'
    email 'hack@email.com'
    password pw
    password_confirmation pw
  end
end
