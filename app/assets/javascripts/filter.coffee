class Filter



  visible: (node) ->
    /U/.test node.text

  # window.tag_get_line.set(nodes[0].data["tags"])
  # window.folder_get_line.set(nodes[0].data["path"])


class @FolderFilter extends Filter

  set: (selection) -> window.folder_set_line.set(selection)

class @TagFilter    extends Filter

  set: (selection) -> window.tag_set_line.set(selection)




class @NoteFilter   extends Filter
