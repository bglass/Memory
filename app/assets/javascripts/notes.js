

$(function () {
    $('.notesxx').jstree({
  "plugins" : [ "checkbox" ]});
    $('.notes').on("changed.jstree", function (e, data) {
	var i, j, r = [];
	var request = "";



    });
    $('button').on('click', function () {
	$('.notes').jstree(true).select_node('child_node_1');
	$('.notes').jstree('select_node', 'child_node_1');
	$.jstree.reference('.notes').select_node('child_node_1');
    });
});
