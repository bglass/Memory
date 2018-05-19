class @Event

  constructor: ({@main}) ->
    @state = new State
    @state.save_initial_state()

  selected: (sender, nodes)->

    switch sender

      when '.folders'
        paths = @main.folder.filter.save(nodes)
        @state.add "folder", paths
        @main.tag.filter.reset()
        @main.tag.tree.deselect_all()
        @main.note.search()
        @main.tag.search()

      when '.tags'
        names = @main.tag.filter.save(nodes)
        @state.add "tag", names
        @main.note.tree.deselect_all()
        @main.note.search()

      when '.notes'
        notes = @main.note.filter.save(nodes)
        @state.add "note", notes
        if nodes.length
          @main.book.update_by_ids(nodes)
        else
          @main.book.clear()

        @state.save_state()


  input: (sender, value) ->

    switch sender

      when '.note_search'
        @main.note.search()

      when '.folder_search'
        @main.folder.search()

      when '.tag_search'
        @main.tag.search()

      when '.book_search'
        @main.book.search()

  key: (sender, key) ->
    # console.log sender, key

  wiki_link: (path) ->
    @snap_state()
    @main.book.update_by_path([path])


  pop_state: (e) =>
    if folders = e.state["folder"]
      @main.folder.select_nodes_by_paths folders

    if tags = e.state["tag"]
      @main.tag.select_nodes_by_names tags

    if notes = e.state["note"]
      @main.note.select_nodes_by_filenames notes

  # private helpers

  snap_state: ->
    @state.add "folder", @main.folder.filter.selected_paths
    @state.add "tag",    @main.tag.filter.selected_names
    @state.add "note",   @main.note.filter.selected_notes
    @state.save_state()

  edit_article: (e)->
    unit = $(e.currentTarget)
    file = e.currentTarget.dataset.file
    new Editor unit, file
