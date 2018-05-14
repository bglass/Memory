class Book

  constructor: (@tag, @url) ->
    @unit = $(@tag)
    @clear()

  update: (nodes) ->
    @clear()
    selection = ( nodes.map (node) -> node.id )
    $.get(@url, selected: selection, (collection) =>
      for article in collection
        @unit.append("<div class='article'></div>")
        new Article(".article", article)
        @unit.append("<hr/>")
    )

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()

$ ->
  window.book = new Book(".book", '/book/')
