# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

aluno1 = Aluno.create({nusp: 10293102, departamento: 'PMR', user_attributes: {nome: 'Rogerinho',
  email: 'roger@usp.br', password: 'achouerradootario', password_confirmation: 'achouerradootario'
}})

docente1 = Docente.create({nusp: 2293402, departamento: 'PEF', user_attributes: {nome: 'Provasi',
  email: 'provasi@usp.br', password: 'sanderson', password_confirmation: 'sanderson'
}})

docente3 = Docente.create({nusp: 2922384, departamento: 'PMR', user_attributes: {nome: 'Rafael',
  email: 'rafael@usp.br', password: 'letmein', password_confirmation: 'letmein'  
}})

representante1 = RepresentanteExterno.create({RG: 109320129, UF: 'São Paulo', user_attributes: {
  nome: 'Rebecca', email: 'rebecca@insper.br', password: 'inspermelhorqueausp', 
  password_confirmation: 'inspermelhorqueausp'
}})

admin1 = Admin.create({nusp: 10343122, user_attributes: {nome: 'Gabriel', 
  email: 'gabriel@usp.br', password: 'saidoleft4deadLucas', 
  password_confirmation: 'saidoleft4deadLucas'  
}})

lmo = Laboratorio.create({nome: 'LMO', localizacao: 'Escola Politécnica (EPUSP)', 
  descricao: 'Offshore Mechanics Laboratory', responsavel: docente1
})
lmo.docentes << docente1

gmsie = Laboratorio.create({nome: 'GMSIE', localizacao: 'Escola Politécnica (EPUSP)',
  descricao: 'Grupo de Mecanica dos Solidos e Impacto em Estruturas', responsavel: docente3 
})
gmsie.docentes << docente3

aluno2 = Aluno.create!({nusp: 1, departamento: 'PMR', user_attributes: {nome: 'aluno1',
  email: 'aluno@aluno1', password: '111111', password_confirmation: '111111'
}})

docente2 = Docente.create!({nusp: 2, departamento: 'PEF', user_attributes: {nome: 'docente1',
  email: 'docente@docente1', password: '111111', password_confirmation: '111111'
}})

representante2 = RepresentanteExterno.create!({RG: 123, UF: 'São Paulo', user_attributes: {
  nome: 'externo1', email: 'externo@externo1', password: '111111', 
  password_confirmation: '111111'
}})

admin2 = Admin.create!({nusp: 10343122, user_attributes: {nome: 'admin1', 
  email: 'admin@admin1', password: '111111', 
  password_confirmation: '111111'  
}})
