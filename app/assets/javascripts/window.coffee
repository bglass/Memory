$ ->
  
  window.note = new Tree
    filter: new NoteFilter
    tag:    '.note_tree'
    url:    '/notes/'

  window.folder = new Tree
    filter: new FolderFilter
    tag: '.folder_tree'
    url: '/folders/'

  window.tag = new Tree
    filter: new TagFilter
    tag: '.tag_tree'
    url: '/tags/'
