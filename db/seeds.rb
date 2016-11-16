# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cadastrando as Categorias"
categories = [
			 "Equipamentos Diagnóstico por Imagem",
			  "Equipamentos Médicos Diversos",
			  "Equipamentos Medicina Veterinária",
			  "Softwares Médicos/Hospitalares",
			  "Assistência e Manutenção Técnica",
			  "Equipamentos para Odontologia",
			  "Estética & Saúde",
			  "Divulgue sua Empresa/Serviço",
			  "Quero Comprar / Estou Procurando",
			  "Oportunidades de Emprego",
			  "Cursos & Eventos",
			  "Outros"
			]

categories.each do |category|
	Category.find_or_create_by(description: category)
end	
puts "Cadastro Finalizado!"


puts "#############################################################################"
puts "#############################################################################"
puts "#############################################################################"


puts "Cadastrando Planos"

plans = [
   {name: "Plano Free", identifier: "free_plan", amount: 0, ads_qtd: 2, feature_qtd: 0, trial: 0, status: true},
   {name: "Plano Bronze", identifier: "bronze_plan", amount: 1990, ads_qtd: 5, feature_qtd: 2, trial: 0, status: true},
   {name: "Plano Prata", identifier: "silver_plan", amount: 2990, ads_qtd: 10, feature_qtd: 5, trial: 0, status: true},
   {name: "Plano Ouro", identifier: "gold_plan", amount: 3990, ads_qtd: 30, feature_qtd: 15, trial: 0, status: true}
]


plans.each do |plan|
	Plan.find_or_create_by(plan)
end	
puts "Cadastro Finalizado!"