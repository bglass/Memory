$ ->

  event = new Event
    window: window

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

  window.folder_get_line = new StatusLine
    tag: ".state_folder_get"

  window.tag_set_line    = new StatusLine
    tag: ".state_tag_set"

  window.tag_get_line    = new StatusLine
    tag: ".state_tag_get"

  window.date_set_line    = new StatusLine
    tag: ".state_date_set"
  window.date_get_line    = new StatusLine
    tag: ".state_date_get"

  window.book = new Book
    window: window
    tag:  ".book"
    url:  "/book/"
