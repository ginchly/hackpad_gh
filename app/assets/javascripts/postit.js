function addIdea() {
    
  if (jQuery) {  
  	ideaCount = ideaCount + 1;
      var idea = document.getElementById('idea');
      $('#ideaList').append('<li id="draggable'+ ideaCount + '"><a href="#"><p>' + idea.value + '</p></a></li>');
		$( '#draggable'+ ideaCount).draggable();
  } else {
      // jQuery is not loaded
  }
  

  return false;
}
