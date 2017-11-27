FactoryGirl.define do
  factory :user do
    @pass = '1q2w' + FFaker::Internet.password
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password @pass
    password_confirmation @pass
  end
end
