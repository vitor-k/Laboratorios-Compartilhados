FactoryBot.define do
  sequence(:email) { |n| "user_#{n}@email.com" }

  factory :admin_user, class: 'User' do
    association :meta, factory: :admin
    nome { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    meta 
  end

  factory :admin do
    nusp { rand(100000..11000000) }
  end

end