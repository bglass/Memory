$ ->
  $('.folder_tree').jstree
    'core':
      'animation': false
      'check_callback': true
      'themes': 'icons': false
      # 'themes': 'stripes': true
      # 'data':
      #   'url': (node) ->
      #     if node.id == '#' then 'ajax_demo_roots.json' else 'ajax_demo_children.json'
      #   'data': (node) ->
      #     { 'id': node.id }
    'types':
      '#':
        'max_children': 1
        'max_depth': 4
        'valid_children': [ 'root' ]
      'root':
        'icon': '/static/3.3.5/assets/images/tree_icon.png'
        'valid_children': [ 'default' ]
      'default': 'valid_children': [
        'default'
        'file'
      ]
      'file':
        # 'icon': 'glyphicon glyphicon-file'
        'icon': false
        'valid_children': []
    'plugins': [
      'contextmenu'
      'dnd'
      'search'
      'state'
      # 'types'
      'wholerow'
    ]
  return

# ---
