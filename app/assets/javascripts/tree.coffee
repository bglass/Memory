class @Tree

  constructor: ({@filter, @tag, @url, @event}) ->
    @unit = $(@tag)
    @tree = @create_load_jstree()
    @selection_handler()

  sort: (a, b) ->
    @filter.sort(
      @tree.get_node(a),
      @tree.get_node(b)
    )

  create_load_jstree: ->
    @unit.jstree
      'plugins': [ "wholerow", "search", "sort" ]
      'search':
        "show_only_matches": true
        "search_callback": (str, node) => @filter.visible(node)
      "sort": (a, b) => @sort(a,b)
      'core':
        "animation" : 0
        'themes': 'icons': false
        'data': 'url': @url
    @unit.jstree(true)

  selection_handler: ->
    @unit.on 'changed.jstree', (e, data) =>
      nodes = @get_nodes data.selected
      @event.selected(@tag, nodes)

    @unit.on 'keydown.jstree', '.jstree-anchor', (e) =>
      @event.key(@tag, e.which)


  get_nodes: (selection) ->
    selection.map (id) => @tree.get_node(id);

  get_names: (selection) ->
    @get_nodes(selection).map (node) -> node.text

  get_data: (selection) ->
    @get_nodes(selection).map (node) -> node.data

  model: ->
    @tree._model.data



  search: =>
    @tree.search("B")

  select_nodes_by_filenames: (fnames) ->
    @select_nodes @find_by_filenames fnames

  select_nodes_by_paths: (paths) ->
    @select_nodes @find_by_paths paths

  select_nodes_by_names: (names) ->
    @select_nodes @find_by_names names

  select_nodes: (ids) ->
    @tree.deselect_all(true)
    @tree.select_node ids

  find_by_filenames: (fnames)->
    lookup = {}
    for i, item of @model()
      if item.data and item.data.filename
        lookup[item.data.path + "/" + item.data.filename] = item.id
    console.log fnames, lookup
    fnames.map (f) -> lookup[f]

  find_by_paths: (paths)->
    lookup = {}
    for i, item of @model()
      if item.data and item.data.path
        lookup[item.data.path] = item.id
    paths.map (p) -> lookup[p]

  find_by_text: (texts) ->
    lookup = {}
    for i, item of @model()
      if item.text
        lookup[item.text] = item.id
    texts.map (t) -> lookup[t]
