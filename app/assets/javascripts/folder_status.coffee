class FolderStatus


  wanted: (selected)->
    window.folder_set_line.set(selected)

  actual: (nodes) ->
    window.folder_get_line.set(nodes[0].data["path"])
    # console.log nodes[0].data["tags"]
    # sel = selection[0]
    # folder = window.note_tree[sel].folder
    #
    #
    # sel = selection.first
    # window.note_tree.




$ ->
  window.folder_status = new FolderStatus


      #
      #
      # when '.note_tree'
      #   window.folder_status.actual(selection)
      #
      #
