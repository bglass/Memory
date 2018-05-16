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
