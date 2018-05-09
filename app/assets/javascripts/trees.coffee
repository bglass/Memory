# class Tree
#   constructor: (tag, url) ->
#     tree = $(tag)
#
#     create(tree)
#     load(tree, url)
#     selection_handler(tag)
#
#   create = (tree) ->
#     tree.tree autoOpen: 1
#
#   load = (tree, url) ->
#     tree.tree('loadDataFromUrl', url)
#
#   selection_handler = (tag) ->
#     $(tag).on 'tree.click', (e) ->
#       multi_select(tag, e)
#
#   multi_select = (tag, e) ->
#     # Disable single selection
#     e.preventDefault()
#     if window.event.ctrlKey
#       selected_node = e.node
#       if selected_node.id == undefined
#         console.log 'The multiple selection functions require that nodes have an id'
#       if $(tag).tree('isNodeSelected', selected_node)
#         $(tag).tree 'removeFromSelection', selected_node
#       else
#         $(tag).tree 'addToSelection', selected_node
#     else
#       $(tag).tree 'selectNode', null
#       $(tag).tree 'addToSelection', e.node
#
#
# $ ->
#   notes   = new Tree('.note_tree',   '/notes/')
#   folders = new Tree('.folder_tree', '/folders/')
#   tags    = new Tree('.tag_tree',    '/tags/')

$ ->
  $('.note_tree').jstree 'core': 'data': [
    'Simple root node'
    {
      'text': 'Root node 2'
      'state':
        'opened': true
        'selected': true
      'children': [
        { 'text': 'Child 1' }
        'Child 2'
      ]
    }
  ]
