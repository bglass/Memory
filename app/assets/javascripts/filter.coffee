class Filter

  visible: (node) ->
    /U/.test node.text



  # window.tag_get_line.set(nodes[0].data["tags"])
  # window.folder_get_line.set(nodes[0].data["path"])

  contains_all: (needed, have) ->
    return true if not needed.length
    for item in needed
      if not (item in have)
        return false
    return true

  contains_one: (needed, have) ->
    return true if not needed.length
    for item in needed
      if item in have
        return true
    return false

  starts_with_one: (needed, have) ->
    return true if not needed.length
    for folder in needed
      if have.startsWith folder
        return true
    return false

  subtract_tags:  (tags) ->



class @FolderFilter extends Filter

  constructor: (parent)->
    parent.selected_paths = []


  save: (nodes) ->
    paths   = nodes.map (node) -> node.data.path
    window.folder.selected_paths = paths
    window.folder_set_line.set(paths)

class @TagFilter    extends Filter

  constructor: (parent) ->
    parent.selected_names = []

  save: (nodes) ->
    names = nodes.map (node) -> node.text
    window.tag.selected_names = names
    window.tag_set_line.set names

class @NoteFilter   extends Filter

  visible: (node) ->
    # @contains_all(
    @contains_one(window.tag.selected_names, node.data.tags) and @starts_with_one(window.folder.selected_paths, node.data.path)
