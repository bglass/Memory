

$(function () {
    $('.folder_tree').jstree({
  "plugins" : [ "checkbox" ]});
    $('.folder_tree').on("changed.jstree", function (e, data) {
	var i, j, r = [];
	var request = "";



    });
    $('button').on('click', function () {
	$('.folder_tree').jstree(true).select_node('child_node_1');
	$('.folder_tree').jstree('select_node', 'child_node_1');
	$.jstree.reference('.folder_tree').select_node('child_node_1');
    });
});
