FactoryGirl.define do
  factory :wiki do
    title "MyString"
    body "This is text for a body of a wiki during test."
    private false
    user { create(:user) }
  end
end
