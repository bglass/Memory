class Tree

  constructor: (@tag, @url) ->
    @unit = $(@tag)
    @create_load_jstree()
    @selection_handler()

  create_load_jstree: ->
    @unit.jstree
      'plugins': [ "wholerow" ]
      'core':
        "animation" : 0
        'themes': 'icons': false
        'data': 'url': @url
      'data': (node) ->
        { 'id': node.id }

  selection_handler: ->
    @unit.on 'changed.jstree', =>
      state = @unit.jstree().get_selected()
      window.evt.selected(@tag, state)

$ ->

  notes   = new Tree('.note_tree',   '/notes/')
  folders = new Tree('.folder_tree', '/folders/')
  tags    = new Tree('.tag_tree',    '/tags/')
