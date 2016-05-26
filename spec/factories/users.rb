FactoryGirl.define do
  pw = ('a'..'h').to_a.shuffle.join
  name = ('a'..'g').to_a.shuffle.join
  user_email = name + "@email.com"
  factory :user do
    username name
    email user_email 
    password pw
    password_confirmation pw
  end
end
