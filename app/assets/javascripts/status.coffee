class Status


  

class TagState extends Status

  wanted: (selected) ->
    window.tag_set_line.set(selected)

  actual: (nodes) ->
    window.tag_get_line.set(nodes[0].data["tags"])



class FolderState extends Status


  wanted: (selected) ->
        window.folder_set_line.set(selected)

  actual: (nodes) ->
    window.folder_get_line.set(nodes[0].data["path"])



$ ->
  window.tag_status    = new TagState
  window.folder_status = new FolderState
