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

  def create_checkbox(object, user)
    return if object.nil?
    html = ''
    
    object_name = object.class.to_s.downcase
      
    html += "<div class='form-check'>"\
    "<input class='form-check-input pokemons_#{user}' type='checkbox' value=#{object.id} id='#{object_name}_#{object.id}'"\
    "name='#{object_name}[#{user}][]' onclick='calculateBaseExperience(this, \"#{user}\")' data-experience='#{object.base_experience.to_s}'>"\
    "<label class='form-check-label' for='#{object_name}[#{user}][#{object.id}]'>#{object.name}</label>
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
end