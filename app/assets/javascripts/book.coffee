class @Book

  constructor: ({@tag, @url, @context}) ->
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
          context: @context
    )

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()
