class TagStatus

  wanted: (selected)->
    window.tag_set_line.set(selected)

  actual: (nodes) ->
    window.tag_get_line.set(nodes[0].data["tags"])

$ ->
  window.tag_status = new TagStatus
  # window.tag_status    = new TagStatus
  #
  #
  #
  #
  #     when '.note_tree'
  #       window.content.update(selection)
  #       window.folder_status.actual(selection)
  #       window.tag_status.actual(selection)
  #
  #     when '.folder_tree'
  #       window.folder_status.wanted(selection)
  #
  #     when '.tag_tree'
  #       window.tag_status.wanted(selection)
