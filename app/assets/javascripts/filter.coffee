class Filter

  visible: (node) ->
    /U/.test node.text



  # window.tag_get_line.set(nodes[0].data["tags"])
  # window.folder_get_line.set(nodes[0].data["path"])






class @FolderFilter extends Filter

  save: (selection) ->
    records = window.folder.get_data(selection)
    paths   = records.map (data) -> data.path
    window.folder.selected_paths = paths
    window.folder_set_line.set(paths)

class @TagFilter    extends Filter

  save: (selection) ->
    names = window.tag.get_names(selection)
    window.tag.selected_names = names
    window.tag_set_line.set names

class @NoteFilter   extends Filter

  contains_all: (tags) ->
    for tag in window.tag.selected_names
      if not (tag in tags)
        return false
    return true

  contains_one: (tags) ->
    for tag in window.tag.selected_names
      if tag in tags
        return true
    return false

  subtract_tags:  (tags) ->



  visible: (node) ->
    # @contains_all(node.data.tags)
    @contains_one(node.data.tags)
