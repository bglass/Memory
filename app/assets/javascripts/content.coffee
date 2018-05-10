class Content

  constructor: (@tag, @url) ->
    @unit = $(@tag)
    @clear()

  update: (selection) ->
    if selection.length
      $.get(@url, selected: selection, (content) => @set(content) )
    else
      @clear()

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @set("nothing to display")

$ ->
  window.content = new Content(".content_display", '/display/')
