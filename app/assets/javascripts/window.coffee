$ ->

  note_filter   = new NoteFilter
  tag_filter    = new TagFilter
  folder_filter = new FolderFilter


  window.note   = new Tree filter: note_filter,   tag: '.note_tree', url: '/notes/'
  window.folder = new Tree filter: folder_filter, tag: '.folder_tree', url: '/folders/'
  window.tag    = new Tree filter: tag_filter,    tag: '.tag_tree', url: '/tags/'



# class @Notes extends Tree

  # constructor: ->
  #   @filter = new NoteFilter(this)
  #   @tag = '.note_tree'
  #   @url = '/notes/'
  #   super
#
# class @Folders extends Tree
#
#   constructor: ->
#     @filter = new FolderFilter(this)
#     @tag = '.folder_tree'
#     @url = '/folders/'
#     super
#
#
# class @Tags extends Tree
#
#   constructor: ->
#     @filter  = new TagFilter(this)
#     @tag = '.tag_tree'
#     @url = '/tags/'
#     super
