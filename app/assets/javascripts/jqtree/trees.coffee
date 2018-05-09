class Tree
  constructor: (@tag, @url) ->
    @tree = $(@tag)
    @tree.tree autoOpen: 1
    @tree.tree('loadDataFromUrl', @url)



$ ->

  notes   = new Tree('.note_tree',   '/notes/')
  folders = new Tree('.folder_tree', '/folders/')
  tags    = new Tree('.tag_tree',    '/tags/')


  # $('.folder_tree').tree autoOpen: 1
  # $(   '.tag_tree').tree autoOpen: 1
  # $(  '.note_tree').tree autoOpen: 1

  # $('.note_tree'  ).tree('loadDataFromUrl', '/notes/')
  # $('.tag_tree'   ).tree('loadDataFromUrl', '/tags/')
  # $('.folder_tree').tree('loadDataFromUrl', '/folders/')





  # $tree.on 'tree.click', (e) ->
  #   # Disable single selection
  #   e.preventDefault()
  #   selected_node = e.node
  #   if selected_node.id == undefined
  #     console.log 'The multiple selection functions require that nodes have an id'
  #   if $tree.tree('isNodeSelected', selected_node)
  #     $tree.tree 'removeFromSelection', selected_node
  #   else
  #     $tree.tree 'addToSelection', selected_node
  #   return
