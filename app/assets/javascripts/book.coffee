class @Book

  constructor: ({@tag, @url, @main, @event}) ->
    @unit = $(@tag)
    @clear()

  update_by_ids: (nodes) ->
    selection = ( nodes.map (node) -> node.id )
    @update selected: selection

  update_by_path: (paths) ->
    @update paths: paths

  update: (selector) ->
    console.log "Update requesting", @url, selector
    $.get(@url, selector, (collection) =>
      @update_articles(collection)
    )

  update_articles: (collection) ->
    @clear()
    for record in collection
      new Article
        book: @unit
        data: record
        main: @main
    @event_handler()

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()

  event_handler: ->

    window.setTimeout (=>
      $('.article a.internal').click (e) =>
        e.preventDefault()
        @event.wiki_link( e.target.pathname.slice(1) )

      $('.article').dblclick (e) =>
        @event.edit_article(e)

    ), 100      # Minimum value needed: 14 (ms)
                # How to wait without static delay?
