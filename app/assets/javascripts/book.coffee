class @Book

  constructor: ({@tag, @url, @window}) ->
    @unit = $(@tag)
    @clear()

  update: (nodes) ->
    @clear()
    selection = ( nodes.map (node) -> node.id )
    $.get(@url, selected: selection, (collection) =>
      for record in collection
        new Article
          book: @unit
          data: record
          window: @window
    )

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()
