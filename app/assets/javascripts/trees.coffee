class Tree
  constructor: (tag, url) ->
    $(tag).jstree
      'plugins': [ "wholerow" ]
      'core':
        "animation" : 0
        'themes': 'icons': false
        'data': 'url': url
      'data': (node) ->
        { 'id': node.id }

$ ->
  notes   = new Tree('.note_tree',   '/notes/')
  folders = new Tree('.folder_tree', '/folders/')
  tags    = new Tree('.tag_tree',    '/tags/')
