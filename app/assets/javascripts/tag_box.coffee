class @TagBox

  constructor: ({tag: @tag}) ->
    @unit = $(@tag)

  set: (tags) ->
    @unit.empty()
    for tag in tags
      @unit.append "<div class='tag'>#{tag}</div>"
