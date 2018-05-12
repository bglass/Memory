class Tree

  constructor: (@tag, @url) ->
    @unit = $(@tag)
    @tree = @create_load_jstree()
    @selection_handler()

  create_load_jstree: ->
    @unit.jstree
      'plugins': [ "wholerow" ]
      'core':
        "animation" : 0
        'themes': 'icons': false
        'data': 'url': @url
    @unit.jstree(true)

  selection_handler: ->
    @unit.on 'changed.jstree', (e, data) =>
      nodes = @get_nodes data.selected
      window.evt.selected(@tag, data.selected, nodes)

  get_nodes: (selection) ->
    selection.map (id) => @tree.get_node(id);


$ ->

  window.note_tree   = new Tree('.note_tree',   '/notes/')
  window.folder_tree = new Tree('.folder_tree', '/folders/')
  window.tag_tree    = new Tree('.tag_tree',    '/tags/')
