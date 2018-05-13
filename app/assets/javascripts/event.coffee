class Event

  selected: (sender, nodes)->

    switch sender

      when '.folder_tree'
        window.folder.filter.save(nodes)
        window.tag.search()
        window.note.search()

      when '.tag_tree'
        window.tag.filter.save(nodes)
        window.note.search()

      when '.note_tree'
        window.book.update(nodes)


$ ->

  window.evt   = new Event
