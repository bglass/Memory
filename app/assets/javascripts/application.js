// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jstree
//= require_tree .


$(function () {
    $('.folders').jstree({
  "plugins" : [ "checkbox" ]});
    $('.folders').on("changed.jstree", function (e, data) {
	var i, j, r = [];
	var request = "";
  $('.folders').jstree('open_all');

	for(i = 0, j = data.selected.length; i < j; i++) {
	     r.push(data.instance.get_node(data.selected[i]).id);
	    // r.push(data.instance.get_node(data.selected[i]).text);
	    // r.push(data.selected[i]);
	}
//	$("#edit").append('variables:' + e + '/' + data.instance.get_node(data.selected[0]));

//	window.location.href = "/items/" + data.instance.get_node(data.selected[0]).id;

//	$('#edit').load("/items/" + r.join(',') + "/edit" );

//	request = "/items/" + data.instance.get_node(data.selected[0]).id + "/edit";
	request = "/items/" + r.join(',') + "/edit";
//	$('#edit').html(request);
	$('#edit').load(request);



//	$('#edit').html("/items/" + data.instance.get_node(data.selected[0]).id);

    });
    $('button').on('click', function () {
	$('.folders').jstree(true).select_node('child_node_1');
	$('.folders').jstree('select_node', 'child_node_1');
	$.jstree.reference('.folders').select_node('child_node_1');
    });
});
