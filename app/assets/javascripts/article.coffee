class @Article

  constructor: (@tag, data) ->
    articles = $(@tag)
    @unit = articles[articles.length-1]   #?
    @unit = $(@tag)
    console.log "once"
    console.log
    @unit.append(data.html)
    # @clear()

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
