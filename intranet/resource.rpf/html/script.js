$(document).ready(function(){
  //Display
  function open(url) {
    $('#container').css("display", "block");
    $('#container').html("<iframe src='"+url+"' width='100%' height='100%'></iframe><br /><h1><center><font color=white>Pour quitter l'application: cliquez à l'extérieur du cadre et appuyez sur Echap.</font></center></h1>");
  }
  
  function close() {
    $('#container').css("display", "none");
    $('#container').html("");
  }

  //Listeners
  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.open == true) {
      open(item.url);
    }
    if (item.open == false) {
      close();
    }
  });

  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      $.post('http://intranet/close', JSON.stringify({}));
    }
  };

});
