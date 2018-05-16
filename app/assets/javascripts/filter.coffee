class Filter

  # visible: (node) ->
  #   /U/.test node.text

  sort: (a, b) ->
    return  1 if a.text.toLowerCase() > b.text.toLowerCase()
    return -1

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

  paths_to_string: (paths) ->
    return "" if not paths
    if paths.length == 1
      return [ paths[0]+"/" ]

    out = ""
    for p in paths
      out += p+", "
    out.slice(0,-2)

  save: (nodes) ->
    paths   = nodes.map (node) -> node.data.path
    window.folder.selected_paths = paths
    window.folder_set_line.set(@paths_to_string paths)

class @TagFilter    extends Filter

  constructor: (parent) ->
    parent.selected_names = []
    @used_by_notes = []

  visible: (tag) ->
    tag.text in @in_use()



  save: (nodes) ->
    names = nodes.map (node) -> node.text
    window.tag.selected_names = names
    window.tag_display.set names

  reset: ->
    @save([])
    @used_by_notes = {}

  append_in_use: (tags)->
    for tag in tags
      @used_by_notes[tag] = null

  in_use: ->
    tags = []
    for tag, x of @used_by_notes
      tags.push tag
    tags

  extra_tags: (tags) ->
    extra = []
    for tag in tags
      extra.push tag if tag not in window.tag.selected_names
    extra

class @NoteFilter   extends Filter

  sort: (a, b) ->
    return  1 if a.data.date < b.data.date
    return -1



  visible: (node) ->

    wanted_tags     = window.tag.selected_names
    wanted_folders  = window.folder.selected_paths
    actual_tags     = node.data.tags
    actual_folder   = node.data.path

    tag_match    = @contains_one(wanted_tags, actual_tags)
    folder_match = @starts_with_one(wanted_folders, actual_folder)
    visible = tag_match and folder_match

    window.tag.filter.append_in_use(actual_tags) if visible
    visible
