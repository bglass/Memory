class Content

  constructor: (@tag, @url) ->
    @unit = $(@tag)
    @clear()

  update: (nodes) ->
    if nodes.length
      selection = nodes.map (node) -> node.id
      $.get(@url, selected: selection, (content) => @set(content) )
    else
      @clear()

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @set("nothing to display")

$ ->
  window.content = new Content(".content_display", '/display/')
