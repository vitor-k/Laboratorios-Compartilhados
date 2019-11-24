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

    trait :aluno_vinculado do
      association :meta, factory: [:aluno, :vinculado]
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

    trait :vinculado do
      association :laboratorio, factory: :laboratorio
    end
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

    transient do
      tem_responsavel { true }
    end

    after(:build) do |laboratorio, options|
      if(options.tem_responsavel)
        docente_user = create(:user, :docente)
        laboratorio.responsavel = Docente.find(docente_user.meta_id)
      end
    end
  end

  factory :postagem do
    texto{ FFaker::Book.description }
    titulo{ FFaker::Product.product_name }
    association :laboratorio, factory: :laboratorio
    association :user, factory: [:user, :aluno]
  end

  factory :equipamento do
    nome { FFaker::Product.product }
    funcao { FFaker::Product.product_name }
    taxa { rand(100..10000) }
    laboratorio
  end

  factory :servico do
    nome { FFaker::Product.product }
    descricao { FFaker::Product.product_name }
    taxa { rand(100..10000) }
    laboratorio
  end

  factory :pedido do
    dataInicio { FFaker::Time.datetime( {:year_latest => -1, :year_range => 1}) }
    dataFim { FFaker::Time.datetime( {:year_latest => -3, :year_range => 1}) }
    descricao { FFaker::Product.product_name }
    aceito { rand(100) > 50 }
    association :user, factory: [:user, :aluno]
    escolha = (FFaker::Random.rand(100) > 50)
    if(escolha)
      association :equipamento, factory: :equipamento
    else
      association :servico, factory: :servico
    end
    after(:build) do |pedido|
      if(escolha)
        pedido.laboratorio_id = pedido.equipamento.laboratorio_id
      
      else
        pedido.laboratorio_id = pedido.servico.laboratorio_id
      end
    end
  end

  factory :pedido_responsabilidade do
    justificativa { FFaker::Book.description }
    after(:build) do |pedido_responsabilidade|
      docente_user = create(:user, :docente)
      # pedido_responsabilidade.id_docente = Docente.find(docente_user.meta_id).id
      pedido_responsabilidade.id_docente = docente_user.id
      pedido_responsabilidade.id_laboratorio = create(:laboratorio).id
    end
  end


end