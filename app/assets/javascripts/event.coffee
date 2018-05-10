class Event

  selected: (sender, selection)->

    switch sender

      when '.note_tree'
        window.content.update(selection)

      when '.folder_tree'
        window.folder_line.set selection.toString()

      when '.tag_tree'
        window.tag_line.set selection.toString()




$ ->

  window.evt   = new Event
