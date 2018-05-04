$ ->
  $('.tag_tree').jstree
    'core':
      'animation': false
      'check_callback': true
      'themes': 'icons': false
    'types':
      '#':
        'max_children': 0
        'max_depth': 0
        'valid_children': [ 'root' ]
      'root':
        'icon': '/static/3.3.5/assets/images/tree_icon.png'
        'valid_children': [ 'default' ]
      'default': 'valid_children': [
        'default'
        'file'
      ]
      'file':
        'icon': 'glyphicon glyphicon-file'
        'icon': false
        'valid_children': []
    'plugins': [
      'contextmenu'
      'dnd'
      'search'
      'state'
      'wholerow'
    ]
  return

# ---
