

$(function () {
    $('.tags').jstree({
  "plugins" : [ "checkbox" ]});
    $('.folders').on("changed.jstree", function (e, data) {
	var i, j, r = [];
	var request = "";



    });
    $('button').on('click', function () {
	$('.tags').jstree(true).select_node('child_node_1');
	$('.tags').jstree('select_node', 'child_node_1');
	$.jstree.reference('.tags').select_node('child_node_1');
    });
});
