class Tree
  constructor: (tag, url) ->
    create(tag)
    load(tag, url)
    multi_select(tag)

  create = (tag) ->
    $(tag).tree autoOpen: 1

  load = (tag, url) ->
    $(tag).tree('loadDataFromUrl', url)

  multi_select = (tag) ->
    $(tag).on 'tree.click', (e) ->
      # Disable single selection
      e.preventDefault()
      selected_node = e.node
      if selected_node.id == undefined
        console.log 'The multiple selection functions require that nodes have an id'
      if $(tag).tree('isNodeSelected', selected_node)
        $(tag).tree 'removeFromSelection', selected_node
      else
        $(tag).tree 'addToSelection', selected_node
      return




$ ->
  notes   = new Tree('.note_tree',   '/notes/')
  folders = new Tree('.folder_tree', '/folders/')
  tags    = new Tree('.tag_tree',    '/tags/')
