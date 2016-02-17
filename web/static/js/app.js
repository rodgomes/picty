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
        $.each(result, function() {
            options.append($("<option />").val(this).text(this));
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
      var jsonResponse = $.parseJSON(result);

      if (jsonResponse.photos && jsonResponse.photos.photo) {
        renderSearchResult(jsonResponse.photos.photo);
      }

  });
}

function renderSearchResult(photos){
  var count = 0,
  showMax = 18,
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
    layout: '332432',
    width: '100%',
    gutter: '5px',
  });
}

function getImageHtml(flickrUrl, imageUrl, title){
  return "<a href='"+ flickrUrl+ "'><img alt='" +title+ "' src='"+imageUrl+"'/></a>";
}

$(function() {
    $(".search-result").hide();
    loadCities();
    $("#search_btn").on('click', function (e) {
			search();
		});
});
