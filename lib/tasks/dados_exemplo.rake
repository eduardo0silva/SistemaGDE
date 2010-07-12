require 'faker'

namespace :db do
  desc "Preenche o banco com dados exemplo"
  
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = Usuario.create!(:nome => "Usuario Exemplo", :email => "testemail@teste.com", :senha => "123456", :senha_confirmation => "123456")
    admin.toggle!(:admin)
    
    99.times do |n|
      strNome = Faker::Name.name
      email = "eduardo#{n}silva@gmail.com"
      senha = "123456"
      Usuario.create!(:nome => strNome, :email => email, :senha => senha, :senha_confirmation => senha)
    end
    
    Usuario.all(:limit => 6).each do |us|
      50.times do
        us.microposts.create!(:conteudo => Faker::Lorem.sentence(5))
      end
    end
  
  end
  
end