function thisPlayerHasWon(clickedTD){
  const thisRow = $(clickedTD).parent();
  let rowWin = true;
  const currentPlayer = $('#player').html();
  $(thisRow).find('td').each(function(item){
    if (!$(this).hasClass(currentPlayer)){ // if this TD does NOT have the class for this player then rowWin false
      rowWin = false;
    }
  });

  return rowWin;
}

$(document).ready(function(){

  $('td').click(function(){
    const player = $('#player').html();
    console.log(player, ' clicked me');
    $(this).addClass(player);

    if (thisPlayerHasWon(this)){
      $('#message').html(`Game Over! <a href="">Play Again</a>`);
    }

    let newPlayer = '';
    if (player === 'X'){
      newPlayer = 'O';
    } else {
      newPlayer = 'X';
    }
    $('#player').html(newPlayer);

  });

});
