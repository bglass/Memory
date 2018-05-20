class @NoteFilter   extends Filter

  constructor: ({@main}) ->
    @selected_notes = []

  sort: (a, b) ->
    return  1 if a.data.date < b.data.date
    return -1

  visible: (node) ->
    wanted_tags     = @main.tag.filter.selected_names
    wanted_folders  = @main.folder.filter.selected_paths
    wanted_string   = @input.value()

    actual_tags     = node.data.tags
    actual_folder   = node.data.path
    actual_text     = node.text
    tag_match    = @contains_one(wanted_tags, actual_tags)
    folder_match = @starts_with_one(wanted_folders, actual_folder)
    search_match = @regular_match(wanted_string, actual_text)

    visible = tag_match and folder_match and  search_match

    @main.tag.filter.append_in_use(actual_tags) if visible
    visible

  save: (nodes) ->
    notes = nodes.map (node) -> node.data.path + "/" + node.data.filename
    @selected_notes = notes
