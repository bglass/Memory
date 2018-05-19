class @Book

  constructor: ({@tag, @url, @context, @event}) ->
    @unit = $(@tag)
    @clear()

  update_by_ids: (nodes) ->
    selection = ( nodes.map (node) -> node.id )
    @update selected: selection

  update_by_path: (paths) ->
    @update paths: paths

  update: (selector) ->
    $.get(@url, selector, (collection) =>
      @update_articles(collection)
    )

  update_articles: (collection) ->
    @clear()
    for record in collection
      new Article
        book: @unit
        data: record
        context: @context
    @link_handler()

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()

  link_handler: ->

    window.setTimeout (=>
      $('.article a.internal').click (e) =>
        e.preventDefault()
        @event.wiki_link( e.target.pathname.slice(1) )
    ), 100      # Minimum value needed: 14 (ms)
                # How to wait without static delay?
