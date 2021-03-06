class @Article

  constructor: ({@book, @data, @main}) ->
    @book.append @page()

  # private

  div = ({@class, id, contents, resource}) ->
    attributes = ""
    attributes += " class='#{@class}'"           if @class
    attributes += " id='#{id}'"                  if id
    attributes += " data-resource='#{resource}'" if resource

    content = ""
    for c in contents
      content += c

    "<div#{attributes}>#{content}</div>"

  page: ->
    div
      class: "box"
      contents: [@folder(), @extra_tags(), @date(), @content()]

  folder: ->
    div
      class: "meta"
      contents: [@relative_path()]

  extra_tags: ->
    tags = @main.tag.filter.extra_tags(@data.tags)

    div
      class: "meta"
      contents: [
        div
          class: "extra_tags"
          contents: @tags(tags)
        ]

  tags: (tags) ->
    out = []
    for tag in tags
      out.push @tag(tag)
    out

  tag: (tag)->
    div
      class: "tag"
      contents: [tag]

  date: ->
    div
      class: "meta"
      contents: [@data.date.slice(0,10)]

  content: ->
    div
      class: "article_frame"
      contents: [
        div
          class: "article"
          id:    @data.id
          resource:  "#{@data.path}/#{@data.resource_name}"
          contents: [@data.html]
      ]

  relative_path: ->

    selected_folders = @main.folder.filter.selected_paths

    if selected_folders.length == 1
      re = RegExp "^#{selected_folders[0]}/?"
      @data.path.replace re, ""
    else
      @data.path
