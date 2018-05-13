class Event

  selected: (sender, selection, nodes)->

    switch sender

      when '.folder_tree'
        window.folder.filter.set(selection)
        window.tag.search()
        window.note.search()

      when '.tag_tree'
        window.tag.filter.set(selection)
        window.note.search()

      when '.note_tree'
        window.content.update(selection)


$ ->

  window.evt   = new Event
