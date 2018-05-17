class @Event

  constructor: ({@global}) ->


  selected: (sender, nodes)->

    switch sender

      when '.folder_tree'
        @global.folder.filter.save(nodes)
        @global.tag.filter.reset()
        @global.tag.tree.deselect_all()
        # @global.note.search()
        @global.tag.search()

      when '.tag_tree'
        @global.tag.filter.save(nodes)
        @global.note.tree.deselect_all()
        @global.note.search()

      when '.note_tree'
        if nodes.length
          @global.book.update(nodes)
        else
          @global.book.clear()


  key: (sender, key) ->
    console.log sender, key
