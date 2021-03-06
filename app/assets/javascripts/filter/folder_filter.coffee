class @FolderFilter extends Filter

  constructor: ->
    @selected_paths = []

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
    @display.set(@paths_to_string paths)
    @selected_paths = paths

  visible: (node) ->
    wanted_string   = @input.value()
    actual_text     = node.text

    @regular_match(wanted_string, actual_text)
