class Tree

  constructor: (@tag, @url) ->
    @unit = $(@tag)
    @create_load_jstree()

  create_load_jstree: ->
    @unit.jstree
      'plugins': [ "wholerow" ]
      'core':
        "animation" : 0
        'themes': 'icons': false
        'data': 'url': @url
      'data': (node) ->
        { 'id': node.id }

  on_select_update: (unit)->
    @unit.on 'changed.jstree', (evt, data) =>
      selected = @unit.jstree().get_selected()
      unit.update(selected)

  on_select_set: (unit) ->
    @unit.on 'changed.jstree', (evt, data) =>
      selected = @unit.jstree().get_selected()
      unit.set(selected.toString())



$ ->

  notes   = new Tree('.note_tree',   '/notes/')
  folders = new Tree('.folder_tree', '/folders/')
  tags    = new Tree('.tag_tree',    '/tags/')

  notes.on_select_update @content
  folders.on_select_set  @folder_line
  tags.on_select_set     @tag_line
