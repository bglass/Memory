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


# $ ->
#   # always pass csrf tokens on ajax calls
#   $.ajaxSetup headers: 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
#   return


$ ->
  notes   = new Tree('.note_tree',   '/notes/')
  folders = new Tree('.folder_tree', '/folders/')
  tags    = new Tree('.tag_tree',    '/tags/')

  # csrf_token = $('meta[name="csrf-token"]').attr('content')


  $('.note_tree').on 'changed.jstree', (evt, data) ->
    selected = $('.note_tree').jstree().get_selected()
    if selected.length
      $.get('/display/', selected: selected, (content) -> $(".content_display").empty().append(content))
    else
      $('.content_display').empty()






# $.get 'http://example.com/page1.html', (data) ->
#   data = $(data).find('#content').html()
#   $('#content').empty().append data
