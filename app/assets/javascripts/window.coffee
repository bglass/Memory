$ ->

  event = new Event
    global: window

  window.note = new Tree
    event:  event
    filter: new NoteFilter
    tag:    '.note_tree'
    url:    '/notes/'

  window.folder = new Tree
    event:  event
    filter: new FolderFilter
    tag: '.folder_tree'
    url: '/folders/'

  window.tag = new Tree
    event:  event
    filter: new TagFilter
    tag: '.tag_tree'
    url: '/tags/'

  window.tag_display = new TagBox
    tag: ".state_tag_set"

  window.folder_set_line = new StatusLine
    tag: ".state_folder_set"

  window.tag_set_line    = new StatusLine
    tag: ".state_tag_set"

  window.date_set_line    = new StatusLine
    tag: ".state_date_set"

  window.book = new Book
    global: window
    tag:  ".book"
    url:  "/book/"
