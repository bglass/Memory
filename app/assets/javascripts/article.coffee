class @Article

  constructor: ({@book, @data, @global}) ->
    @folder()
    @tags()
    @date()
    @content()

  # private

  folder: ->
    folder = @relative_path()
    @book.append """
    <div class='meta'>#{folder}</div>
    """

  tags: ->
    out = "<div class='meta'><div class='extra_tags'>"
    for tag in @global.tag.filter.extra_tags(@data.tags)
      out += "<div class='tag'>"+tag+"</div>"
    out += "</div></div>"
    @book.append out

  date: ->
    date = @data.date.slice(0,10)
    @book.append """
    <div class='meta'>#{date}</div>
    """

  content: ->
    @book.append """
    <div class=article_frame>
    <div class='article'>#{@data.html}</div></div>
    """


  relative_path: ->

    selected_folders = @global.folder.filter.selected_paths

    if selected_folders.length == 1
      re = RegExp "^#{selected_folders[0]}/?"
      @data.path.replace re, ""
    else
      @data.path
