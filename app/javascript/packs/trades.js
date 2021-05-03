$(document).on('turbolinks:load', function() {
  $('.pokemons_from_user').change(function(){
    calculateBaseExperience(this,'from_user');
    changeAnalisys();
  });

  $('.pokemons_to_user').change(function(){
    calculateBaseExperience(this,'to_user');
    changeAnalisys();
  });

  $('.to_user').change(function(){
    disableEnableUsers();
  });
});

function calculateBaseExperience(el, user){
  let sum = 0,
      avg = 0.0 
  selected_pokemons = $(el).closest('tr').find('input[type=checkbox]:checked');
      
  selected_pokemons.each(function(){
    sum += parseFloat($(this).data('experience'))
  });
  
  $(el).closest('tr').find('#' + user + '_selected_pokemons_base_experience').html(sum)
}

function disableEnableUsers (){
  not_selected_user = $('input[type=radio]:not(:checked)').closest('tr').find('input[type=checkbox]');
  selected_user = $('input[type=radio]:checked').closest('tr').find('input[type=checkbox]');

  not_selected_user.each(function(){
    $(this).removeAttr('enabled');
    $(this).attr('disabled','disabled')
  });

  selected_user.each(function(){
    $(this).removeAttr('disabled');
    $(this).attr('enabled','enabled')
  });
}

function changeAnalisys () {
  let fair_factor = 0.10,
      selected_user_base_experience = parseFloat($('input[type=radio]:checked').closest('tr').find('#to_user_selected_pokemons_base_experience').html());
      current_user_base_experience = parseFloat($('#from_user_selected_pokemons_base_experience').html());
      absolute_difference = 0;
  
  absolute_difference = Math.abs(selected_user_base_experience - current_user_base_experience);

  if (selected_user_base_experience > 0 && current_user_base_experience > 0){
    if (absolute_difference < Math.max(selected_user_base_experience, current_user_base_experience)*fair_factor) {
      $('#change_analisys').html('Troca justa!');
      $('#btn-submit').removeClass('disabled')
    }
    else {
      $('#change_analisys').html('Troca injusta! Escolha melhor os pokemons para trocar.');
      $('#btn-submit').addClass('disabled')

    }
  }
}