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

    @link_handler()

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()

  link_handler: ->

    window.setTimeout (->
      $('.article a.internal').click (e) ->
        e.preventDefault()
        href = $(@).attr('href')
        console.log @
    ), 100      # Minimum value needed: 14 (ms)
                # How to wait without static delay?
