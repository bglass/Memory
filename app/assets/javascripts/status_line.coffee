class @StatusLine

  constructor: ({@tag}) ->
    @unit = $(@tag)
    @clear()

  set: (content) ->
    @unit.empty().append(content.toString())

  clear: ->
    @set("don't know...")
