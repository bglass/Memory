class @Article

  constructor: (@book, @data) ->
    @folder()
    @tags()
    @date()
    @content()

  folder: ->
    @book.append """
    <div class='meta'>Folder: #{@data.path}</div>
    """

  tags: ->
    @book.append """
    <div class='meta'>Tags: #{@data.tags}</div>
    """

  date: ->
    @book.append """
    <div class='meta'>Date: #{@data.date}</div>
    """

  content: ->
    @book.append """
    <div class=article_frame>
    <div class='article'>#{@data.html}</div></div>
    """
