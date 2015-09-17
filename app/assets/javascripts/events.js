$(document).on('ready', function() {
// VARS
  //QUESTION the one w var is not defined, and the one w/o is... why?
  var $pageContent = $('#page-content').children().first()
  activePage = $('#page-content').children().first().attr('id')
      .substr(0, $('#page-content').children().first().attr('id').indexOf('-'))

// PARK

  if (activePage == "park"){
    $('#navbar').next().removeClass('ui container')
  }

  // fill hidden forms w lat&lng when park btn is clicked
  $('#submit-location-btn').on('click', function(){

    var lat = myLayer._geojson.geometry.valueOf().coordinates[1];
    var lng = myLayer._geojson.geometry.valueOf().coordinates[0];

    $('#event_lat').attr('value', lat);
    $('#event_lng').attr('value', lng);
  })

});