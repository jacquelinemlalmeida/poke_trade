require 'rest-client'
require 'json'
require 'csv'

csv_path = "#{Rails.root}/script/pokemons.csv"
CSV.foreach(csv_path, col_sep: ',', headers: true) do |row|
  id = row[0]
  next if id == 772
  name = row[1]
  generation = row[2].to_i.ordinalize
  
  url = "https://pokeapi.co/api/v2/pokemon/#{id}"

  resp = RestClient.get url

  reponse = JSON.parse(resp.body)

  image = reponse["sprites"]["front_default"]
  base_experience = reponse["base_experience"]
  
  pokemon = Pokemon.create({
    name: name.strip, 
    image: image, 
    base_experience: base_experience, 
    generation: generation
  })

  unless pokemon
    puts "Erro Pokemon ID:#{id} não foi criado no banco de dados."
  end  
end  