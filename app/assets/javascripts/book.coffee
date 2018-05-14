class Book

  constructor: (@tag, @url) ->
    @unit = $(@tag)
    @clear()

  update: (nodes) ->
    @clear()
    selection = ( nodes.map (node) -> node.id )
    $.get(@url, selected: selection, (collection) =>
      for article in collection
        @render_article(article)

    )

  set: (content) ->
    @unit.empty().append(content)

  clear: ->
    @unit.empty()

  render_article: (article)->
    @unit.append """
    <div class='meta'>Folder: #{article.path}</div>
    <div class='meta'>Tags: #{article.tags}</div>
    <div class='meta'>Date: #{article.date}</div>
    <div class=article_frame>
    <div class='article'>#{article.html}</div></div>
    """


$ ->
  window.book = new Book(".book", '/book/')
