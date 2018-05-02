

$(function () {
    $('.folders').jstree({
  "plugins" : [ "checkbox" ]});
    $('.folders').on("changed.jstree", function (e, data) {
	var i, j, r = [];
	var request = "";



    });
    $('button').on('click', function () {
	$('.folders').jstree(true).select_node('child_node_1');
	$('.folders').jstree('select_node', 'child_node_1');
	$.jstree.reference('.folders').select_node('child_node_1');
    });
});
