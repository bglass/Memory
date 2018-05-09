
class Tree
  this.update =(tag, data) ->
    # $(tag).tree("loadData", data)

  this.no_data = ->
    return [{name: '...'}]

$ ->
  nodata = Tree.no_data()

  $('.folder_tree').tree
    data:     nodata
    autoOpen: 0

  $(   '.tag_tree').tree  data: nodata
  $(  '.note_tree').tree data: nodata

  $('.note_tree'  ).tree('loadDataFromUrl', '/notes/')
  $('.tag_tree'   ).tree('loadDataFromUrl', '/tags/')
  $('.folder_tree').tree('loadDataFromUrl', '/folders/')





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
