// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//=require jquery.turbolinks
$(document).ready(function(){
	$(window).keypress(function(e){
		if (e.which == 32 && !!document.getElementById("random-site")){
			e.preventDefault();
			window.location.href = $("#another")[0];
		}
	})


	$('.favor-site').on('click', function(e){
		e.preventDefault();
		var request = $.ajax({
      url: this.href,
      method: 'post',
      dataType: 'json'

		})

		request.done(function(response){

		})

	})
});