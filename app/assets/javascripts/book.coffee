class @Book

  constructor: ({@tag, @url, @global}) ->
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
          global: @global
    )

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()
