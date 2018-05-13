class Event

  selected: (sender, selection, nodes)->

    switch sender

      when '.folder_tree'
        window.folder.filter.save(selection)
        window.tag.search()
        window.note.search()

      when '.tag_tree'
        window.tag.filter.save(selection)
        window.note.search()

      when '.note_tree'
        window.content.update(selection)


$ ->

  window.evt   = new Event
