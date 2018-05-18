class @Event

  constructor: ({@context}) ->


  selected: (sender, nodes)->

    switch sender

      when '.folder_tree'
        @context.folder.filter.save(nodes)
        @context.tag.filter.reset()
        @context.tag.tree.deselect_all()
        @context.note.search()
        @context.tag.search()

      when '.tag_tree'
        @context.tag.filter.save(nodes)
        @context.note.tree.deselect_all()
        @context.note.search()

      when '.note_tree'
        if nodes.length
          @context.book.update(nodes)
        else
          @context.book.clear()

  input: (sender, value) ->

    switch sender

      when '.note_search'
        window.note.search()
      # when '.folder_search'
      # when '.tag_search'
      # when '.book_search'

  key: (sender, key) ->
    console.log sender, key
