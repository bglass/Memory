class @Event

  constructor: ({@main}) ->

  selected: (sender, nodes)->

    switch sender

      when '.folders'
        @save_state()
        @main.folder.filter.save(nodes)
        @main.tag.filter.reset()
        @main.tag.tree.deselect_all()
        @main.note.search()
        @main.tag.search()

      when '.tags'
        @main.tag.filter.save(nodes)
        @main.note.tree.deselect_all()
        @main.note.search()

      when '.notes'
        @main.note.filter.save(nodes)
        if nodes.length
          @main.book.update_by_ids(nodes)
        else
          @main.book.clear()

  input: (sender, value) ->

    switch sender

      when '.note_search'
        window.note.search()
      # when '.folder_search'
      # when '.tag_search'
      # when '.book_search'

  key: (sender, key) ->
    # console.log sender, key

  wiki_link: (path) ->
    @save_state()
    @main.book.update_by_path([path])

  save_state: ->
      state =
        folder:     @main.folder.filter.selected_paths
        tag:        @main.tag.filter.selected_names
        note:       @main.note.filter.selected_notes
      label = $.now()
      history.pushState(state, "", label)
      # console.log "SAVED", state

  pop_state: (e) =>
    @main.folder.select_nodes_by_paths e.state["folder"]

    # @main.tag.select_nodes    e.state["tag"]
    # @main.note.select_nodes   e.state["note"]
