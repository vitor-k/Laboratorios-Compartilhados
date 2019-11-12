FactoryBot.define do
  sequence(:email) { |n| "user_#{n}@email.com" }

  # factory :admin_user, class: 'User' do
  #   association :meta, factory: :admin
  #   nome { FFaker::Name.name }
  #   email { FFaker::Internet.email }
  #   password { FFaker::Internet.password }
  #   meta 
  # end

  factory :user do
    nome { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }

    trait :admin do
      association :meta, factory: :admin
    end

    trait :aluno do
      association :meta, factory: :aluno
    end

    trait :docente do
      association :meta, factory: :docente
    end

    trait :representante_externo do
      association :meta, factory: :representante_externo
    end
  end

  factory :admin do
    nusp { rand(100000..11000000) }
  end

  factory :aluno do
    nusp { rand(100000..11000000) }
    departamento { FFaker::Vehicle.make }
  end

  factory :docente do
    nusp { rand(100000..11000000) }
    departamento { FFaker::Vehicle.make }
  end

  factory :representante_externo do
    RG { rand(100000..11000000) }
    UF { FFaker::AddressBR.state }
  end

  factory :laboratorio do
    nome { FFaker::CompanyIT.name }
    localizacao { FFaker::AddressBR.street }
    descricao { FFaker::Book.description }
    association :responsavel, factory: :docente

    after(:build) do |laboratorio|
      docente_user = create(:user, :docente)
      laboratorio.responsavel = Docente.find(docente_user.meta_id)
    end
  end

  factory :equipamento do
    nome { FFaker::Product.product }
    funcao { FFaker::Product.product_name }
    taxa { rand(100, 10000) }
    laboratorio
  end

  factory :servico do
    nome { FFaker::Product.product }
    funcao { FFaker::Product.product_name }
    taxa { rand(100, 10000) }
    laboratorio
  end

  


end