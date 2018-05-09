class Tree
  constructor: (tag, url) ->
    tree = $(tag)

    load(tree, url)

  load = (tree, url) ->
    tree.jstree 'core': 'data':
      'url': url
      'data': (node) ->
        { 'id': node.id }

$ ->
  notes   = new Tree('.note_tree',   '/notes/')
  folders = new Tree('.folder_tree', '/folders/')
  tags    = new Tree('.tag_tree',    '/tags/')
