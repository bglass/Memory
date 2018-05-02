

$(function () {
    $('.tag_tree').jstree({
  "plugins" : [ "checkbox" ]});
    $('.folders').on("changed.jstree", function (e, data) {
	var i, j, r = [];
	var request = "";



    });
    $('button').on('click', function () {
	$('.tag_tree').jstree(true).select_node('child_node_1');
	$('.tag_tree').jstree('select_node', 'child_node_1');
	$.jstree.reference('.tag_tree').select_node('child_node_1');
    });
});
