class Book

  constructor: (@tag, @url) ->
    @unit = $(@tag)
    @clear()

  update: (nodes) ->
    @clear()
    selection = ( nodes.map (node) -> node.id )
    $.get(@url, selected: selection, (collection) =>
      for record in collection
        new Article(@unit, record)
    )

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()

$ ->
  window.book = new Book(".book", '/book/')
