class StatusLine

  constructor: (@tag) ->
    @unit = $(@tag)
    @clear()

  set: (content) ->
    @unit.empty().append(content.toString())

  clear: ->
    @set("don't know...")

$ ->
  window.folder_set_line = new StatusLine(".state_folder_set")
  window.folder_get_line = new StatusLine(".state_folder_get")

  window.tag_set_line    = new StatusLine(".state_tag_set")
  window.tag_get_line    = new StatusLine(".state_tag_get")

  window.date_set_line    = new StatusLine(".state_date_set")
  window.date_get_line    = new StatusLine(".state_date_get")
