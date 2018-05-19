$ ->

  event = new Event
    context: window

  window.book = new Book
    context: window
    event:   event
    tag:     ".book"
    url:     "/book/"

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

  # window.tag.input    = new Search
  #   call:  window.tag.search
  #   tag: '.tag_search'

  window.note.filter.input   = new Search
    call:  event.input
    tag: '.note_search'
  #
  # window.folder.input = new Search
  #   call:  window.folder.search
  #   tag: '.folder_search'
  #
  # window.book.input = new Search
  #   call:  window.book.search
  #   tag: '.book_search'

  window.tag.filter.display = new TagBox
    tag: ".state_tag_set"

  window.folder.filter.display = new StatusLine
    tag: ".state_folder_set"

  window.date_set_line    = new StatusLine
    tag: ".state_date_set"
