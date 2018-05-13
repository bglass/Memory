$ ->
  $('#jstree').jstree(
    core: data: [
      {
        'id': '1'
        'parent': '#'
        'text': 'children'
      }
      {
        'id': '2'
        'parent': '1'
        'text': 'search'
      }
      {
        'id': '3'
        'parent': '1'
        'text': 'hyallo'
      }
    ]
    search: search_callback: (str, node) ->
      if node.text == str
        return true
      return
    plugins: [ 'search' ]).on 'ready.jstree', (e, data) ->
      data.instance.search 'hyallo'
