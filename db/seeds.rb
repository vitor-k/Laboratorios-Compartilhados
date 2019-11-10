# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

aluno1 = Aluno.create!({nusp: 10293102, departamento: 'PMR', user_attributes: {nome: 'Rogerinho',
  email: 'roger@usp.br', password: 'achouerradootario', password_confirmation: 'achouerradootario'
}})

docente1 = Docente.create!({nusp: 2293402, departamento: 'PEF', user_attributes: {nome: 'Provasi',
  email: 'provasi@usp.br', password: 'sanderson', password_confirmation: 'sanderson'
}})

representante1 = RepresentanteExterno.create!({RG: 109320129, UF: 'São Paulo', user_attributes: {
  nome: 'Rebecca', email: 'rebecca@insper.br', password: 'inspermelhorqueausp', 
  password_confirmation: 'inspermelhorqueausp'
}})

admin1 = Admin.create!({nusp: 10343122, user_attributes: {nome: 'Gabriel', 
  email: 'gabriel@usp.br', password: 'saidoleft4deadLucas', 
  password_confirmation: 'saidoleft4deadLucas'  
}})