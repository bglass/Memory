class Tree
  constructor: (tag, url) ->
    tree = $(tag)

    create(tree)
    load(tree, url)
    selection_handler(tree)

  create = (tree) ->
    tree.tree autoOpen: 1

  load = (tree, url) ->
    tree.tree('loadDataFromUrl', url)

  selection_handler = (tree) ->
    tree.on 'tree.click', (e) ->
      multi_select(tree, e)
      console.log "Hi"

  multi_select = (tree, e) ->
    # Disable single selection
    e.preventDefault()
    selected_node = e.node
    if selected_node.id == undefined
      console.log 'The multiple selection functions require that nodes have an id'
    if tree.tree('isNodeSelected', selected_node)
      tree.tree 'removeFromSelection', selected_node
    else
      tree.tree 'addToSelection', selected_node




$ ->
  notes   = new Tree('.note_tree',   '/notes/')
  folders = new Tree('.folder_tree', '/folders/')
  tags    = new Tree('.tag_tree',    '/tags/')
