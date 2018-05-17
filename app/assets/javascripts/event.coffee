class @Event

  constructor: ({@window}) ->
    

  selected: (sender, nodes)->

    switch sender

      when '.folder_tree'
        @window.folder.filter.save(nodes)
        @window.tag.filter.reset()
        @window.tag.tree.deselect_all()
        # @window.note.search()
        @window.tag.search()

      when '.tag_tree'
        @window.tag.filter.save(nodes)
        @window.note.tree.deselect_all()
        @window.note.search()

      when '.note_tree'
        if nodes.length
          @window.book.update(nodes)
        else
          @window.book.clear()


  key: (sender, key) ->
    console.log sender, key
