module PokemonsHelper
  def create_checkboxes(objects)
    html = ''
    objects.each do |object|
      object_name = object.class.to_s.downcase
      
      html += "<div class='form-check flex-item' style='flex-basis: 20%'>"\
      "<input class='form-check-input' type='checkbox' value=#{object.id} id='#{object_name}_#{object.id}'"\
      "name='#{object_name}[]'>"\
      "<label class='form-check-label' for='pokemon_#{object.id}'>#{object.name}</label>
      <br>
      <img src=#{object.image}> 
      </div>"       
    end
    html.html_safe
  end

  def create_checkbox(object, user_tag, user_id)
    return if object.nil?
    html = ''
    
    object_name = object.class.to_s.downcase
    disabled = user_tag == "to_user" ? "disabled='disabled'" : ""
      
    html += "<div class='form-check'>"\
    "<input class='form-check-input pokemons_#{user_tag}' type='checkbox' value=#{object.id} id='#{object_name}_#{object.id}_#{user_id}'"\
    "name='#{object_name}[#{user_tag}][]' data-experience='#{object.base_experience.to_s}' #{disabled}>"\
    "<label class='form-check-label' for='#{object_name}[#{user_tag}][#{object.id}]'>#{object.name}</label>
    <br>
    <img src=#{object.image}> 
    </div>"       
    
    html.html_safe
  end

  def calculate_base_experience(pokemons)
    pokemons.pluck(:base_experience).sum 
  end

  FAIR_FACTOR = 0.10
  def is_a_fair_trade?(first_batch_pokemons, second_batch_pokemons)
    first_batch_pokemons_base_experience_avg = calculate_base_experience(first_batch_pokemons)
    second_batch_pokemons_base_experience_avg = calculate_base_experience(second_batch_pokemons)
    debugger
    absolute_difference = (first_batch_pokemons_base_experience_avg - second_batch_pokemons_base_experience_avg).abs

    absolute_difference < ([first_batch_pokemons_base_experience_avg, second_batch_pokemons_base_experience_avg].max)*FAIR_FACTOR
  end

  def get_user_pokemons(trade,user)
    pokemons_json = JSON.parse trade.pokemons_change
    pokemons_id = pokemons_json[user]
    pokemons = Pokemon.where(id: pokemons_id)
    html = '<div class="row">'

    pokemons.each do |pokemon|
      html += '<div class="text-center">'\
                  "<label class=''>#{pokemon.name}</label>"\
                  "<br><img src=#{pokemon.image}>"\
                '</div>'\
             
    end
    html +=  '</div>'
    html.html_safe
  end
end