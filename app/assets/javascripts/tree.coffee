class @Tree

  constructor: ({@filter, @tag, @url}) ->
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
      window.evt.selected(@tag, nodes)

    @unit.on 'keydown.jstree', '.jstree-anchor', (e) =>
      window.evt.key(@tag, e.which)


  get_nodes: (selection) ->
    selection.map (id) => @tree.get_node(id);

  get_names: (selection) ->
    @get_nodes(selection).map (node) -> node.text

  get_data: (selection) ->
    @get_nodes(selection).map (node) -> node.data


  search: ->
    @tree.search("B")
