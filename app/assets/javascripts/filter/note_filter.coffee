class @NoteFilter   extends Filter

  sort: (a, b) ->
    return  1 if a.data.date < b.data.date
    return -1

  regular_match: (re, text) ->
    text.match RegExp re, 'i'

  visible: (node) ->
    wanted_tags     = window.tag.filter.selected_names
    wanted_folders  = window.folder.filter.selected_paths
    wanted_string   = @input.value()

    actual_tags     = node.data.tags
    actual_folder   = node.data.path
    actual_text     = node.text

    tag_match    = @contains_one(wanted_tags, actual_tags)
    folder_match = @starts_with_one(wanted_folders, actual_folder)
    search_match = @regular_match(wanted_string, actual_text)

    visible = tag_match and folder_match and  search_match

    window.tag.filter.append_in_use(actual_tags) if visible
    visible
