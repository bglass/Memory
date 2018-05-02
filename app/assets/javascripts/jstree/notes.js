

$(function () {
    $('.note_tree').jstree({
  "plugins" : [ "checkbox" ]});
    $('.note_tree').on("changed.jstree", function (e, data) {
	var i, j, r = [];
	var request = "";



    });
    $('button').on('click', function () {
	$('.note_tree').jstree(true).select_node('child_node_1');
	$('.note_tree').jstree('select_node', 'child_node_1');
	$.jstree.reference('.note_tree').select_node('child_node_1');
    });
});
