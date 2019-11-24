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
lmo.docentes << docente3

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

equip1 = Equipamento.create({nome: "Equi1", funcao: "equiparum", taxa: 100, laboratorio: gmsie})
lmo.equipamentos << equip1

equip2 = Equipamento.create({nome: "Equi2", funcao: "equipardois", taxa: 200, laboratorio: gmsie})
lmo.equipamentos << equip2


serv1 = Servico.create({nome: "Serv1", descricao: "servicum", taxa: 1000, laboratorio: gmsie})
lmo.servicos << serv1

serv2 = Servico.create({nome: "Serv2", descricao: "servicdois", taxa: 2000, laboratorio: gmsie})
lmo.servicos << serv2

aluno2.laboratorio = lmo
lmo.alunos << aluno2

post1 = Postagem.create({titulo: "Assunto relevante", texto: "Olha que assunto relevante", user: aluno2.user, laboratorio: aluno2.laboratorio})
lmo.postagems << post1
aluno2.user.postagems << post1
post2 = Postagem.create({titulo: "Vagas abertas", texto: "Existem vagas abertas para pesquisadores.", user: docente1.user, laboratorio: lmo})
lmo.postagems << post2
docente1.user.postagems << post2
post3 = Postagem.create({titulo: "Estudo em andamento", texto: "O estudo feito no laboratório está em andamento", user: docente3.user, laboratorio: gmsie})
gmsie.postagems << post3
docente3.user.postagems << post3
post4 = Postagem.create({titulo: "Resultados", texto: "Seguem os resultados dos estudos realizados", user: docente3.user, laboratorio: lmo})
lmo.postagems << post4
docente3.user.postagems << post4
post5 = Postagem.create({titulo: "Anúncio de manutenção", texto: "No dia 25/11/2019 o sistema estará indisponível para uma manutenção programada.", user: admin2.user, laboratorio: nil})
admin2.user.postagems << post5
post6 = Postagem.create({titulo: "Teste da manutenção", texto: "Texto no laboratório LMO", user: admin2.user, laboratorio: lmo})
lmo.postagems << post6
admin2.user.postagems << post6
post7 = Postagem.create({titulo: "Teste da manunteção", texto: "Texto no laboratório GMSIE", user: admin2.user, laboratorio: gmsie})
gmsie.postagems << post7
admin2.user.postagems << post7
