class TagBox

  constructor: (@tag) ->
    @unit = $(@tag)

  set: (tags) ->
    @unit.empty()
    for tag in tags
      @unit.append "<div class='tag'>#{tag}</div>"


$ ->
  window.tag_display = new TagBox(".state_tag_set")
