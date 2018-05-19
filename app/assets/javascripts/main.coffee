class @Main


  event_controller: ->
    @event = new Event(main: @)

  make_book: (arg) ->
    @book = new Book merge arg, main: @, event: @event

  tree: (arg) ->
    new Tree merge arg, event: @event

  input:  (arg) ->
    new Search merge arg, call: @event.input

  tagbox:  (arg) ->
    new TagBox arg

  statusline: (arg) ->
    new StatusLine arg

  notefilter: ->
    new NoteFilter main: @


  tap = (o, fn) -> fn(o); o
  merge = (xs...) ->
    if xs?.length > 0
      tap {}, (m) -> m[k] = v for k, v of x for x in xs

  connect_elements: ->

    @event_controller()

    @make_book
      tag:     ".book"
      url:     "/book/"

    @note = @tree
      filter: @notefilter()
      tag:    '.notes'
      url:    '/notes/'

    @folder = @tree
      filter: new FolderFilter
      tag: '.folders'
      url: '/folders/'

    @tag = @tree
      filter: new TagFilter
      tag: '.tags'
      url: '/tags/'

    @note.filter.input = @input
      tag: '.note_search'

    @tag.filter.input = @input
      tag: '.tag_search'

    @folder.filter.input = @input
      tag: '.folder_search'

    # @book.filter.input = @input
    #   tag: '.book_search'

    @tag.filter.display = @tagbox
      tag: ".state_tag_set"

    @folder.filter.display = @statusline
      tag: ".state_folder_set"

    main.date_set_line    = @statusline
      tag: ".state_date_set"

$ ->
  window.main = new Main
  window.main.connect_elements()
  window.onpopstate = main.event.pop_state
