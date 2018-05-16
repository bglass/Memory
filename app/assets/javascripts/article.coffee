class @Article

  constructor: (@book, record) ->
    @render_article(record)

  render_article: (article)->
    @book.append """
    <div class='meta'>Folder: #{article.path}</div>
    <div class='meta'>Tags: #{article.tags}</div>
    <div class='meta'>Date: #{article.date}</div>
    <div class=article_frame>
    <div class='article'>#{article.html}</div></div>
    """
