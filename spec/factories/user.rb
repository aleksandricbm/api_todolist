FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password 'aq4Awsedvgty'
    password_confirmation 'aq4Awsedvgty'
  end
end
