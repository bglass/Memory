class StatusLine

  constructor: (@tag) ->
    @unit = $(@tag)
    @clear()

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @set("don't know...")

$ ->
  window.folder_line = new StatusLine(".state_folder_set")
  window.tag_line    = new StatusLine(".state_tag_set")
