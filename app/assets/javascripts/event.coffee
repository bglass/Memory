class Event

  selected: (sender, selection, nodes)->

    switch sender

      when '.note_tree'
        window.content.update(selection)
        window.folder_status.actual(nodes)
        window.tag_status.actual(nodes)

      when '.folder_tree'
        window.folder_status.wanted(selection)

      when '.tag_tree'
        window.tag_status.wanted(selection)




$ ->

  window.evt   = new Event
