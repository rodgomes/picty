// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
function loadCities(){

  $.getJSON("/api/locations.json", function(result) {
        var options = $("#city-options");
        var suggestion = $(options).data("suggestion");

        $.each(result, function() {
            var option = $("<option />").val(this).text(this);
            if(this === suggestion){
                option.attr('selected','selected');
            }
            options.append(option);
        });
  });
}

function search(){

  var params = {
      "city": $("#city-options :selected").text(),
      "month": $("#month :selected").val()
   }

  $("body").addClass("loading");
  $(".search-result").show();

  $.getJSON("/api/search.json", params, function(result) {

      var options = $("#city-options");
      if (result) {
        renderSearchResult(result);
      }
  });
}

function renderSearchResult(photos){
  var count = 0,
  showMax = 46,
  rowDiv = $("<div />");

  $.each(photos, function() {
      var url = "https://farm" +this.farm + ".staticflickr.com/"+ this.server+ "/"+this.id+"_" + this.secret+"_m.jpg";
      var flickrUrl = "https://flickr.com/"+this.owner+"/"+this.id;

      count = count +1;
      if (count < showMax){
        rowDiv.append(getImageHtml(flickrUrl, url, this.title));
      }
  });

  $("#photo-grid-container").empty();
  $("#photo-grid-container").append(rowDiv);
  $("body").removeClass("loading");

  $(rowDiv).photosetGrid({
    layout: generateLayout(showMax), //'3434343434343',
    width: '100%',
    gutter: '5px',
  });
}

function generateLayout(maxPictures){
  var count = 0,
  layout = "",
  iter = 0,
  numberOfPics = 3;

  while(count <= maxPictures){
      if(iter % 2 == 0){
        numberOfPics = 3;
      } else {
        numberOfPics = 4;
      }
      layout += numberOfPics;
      count += numberOfPics;
      iter+=1;
  }
  return layout;
}

function getImageHtml(flickrUrl, imageUrl, title){
  return "<a href='"+ flickrUrl+ "' target='_blank'><img alt='" +title+ "' src='"+imageUrl+"'/></a>";
}

$(function() {
    $(".search-result").hide();
    loadCities();
    $("#search_btn").on('click', function (e) {
			search();
		});
});
