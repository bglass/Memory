$ ->
  $('.note_tree').jstree
    'plugins': ['contextmenu', 'dnd', 'search', 'state', 'wholerow' ]
    'core':
      'animation': false
      'check_callback': true
      'themes': 'icons': false
    'types':
      '#':
        'max_children': 1
        'max_depth': 4
        'valid_children': [ 'root' ]
      'root':
        'icon': '/static/3.3.5/assets/images/tree_icon.png'
        'valid_children': [ 'default' ]
      'default': 'valid_children': [ 'default','file' ]
      'file':
        'icon': 'glyphicon glyphicon-file'
        'icon': false
        'valid_children': []

  $('.note_tree').on 'changed.jstree', (evt, data) ->
    selected = $('.note_tree').jstree().get_selected()
    if selected.length
      $('.content_display').load("/display", {"selected": selected})
    else
      $('.content_display').empty()
