class @TagFilter    extends Filter

  constructor: ->
    @selected_names = []
    @used_by_notes = []

  visible: (tag) ->
    tag.text in @in_use()

  save: (nodes) ->
    names = nodes.map (node) -> node.text
    @display.set names
    @selected_names = names

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
      extra.push tag if tag not in @selected_names
    extra
