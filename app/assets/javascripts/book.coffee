class Book

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
  window.book = new Book(".book", '/display/')
