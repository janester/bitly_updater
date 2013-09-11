# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    url "MyString"
    name "MyString"
    clicks 1
  end
end
