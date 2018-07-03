class @Editor

  # constructor: ({@unit}) ->
  #   resource = @unit.dataset.resource
  #   id = "t"+@unit.id
  #   $.get(/editor/, resource: resource, (data) =>
  #     src = data["source"]
  #     $(@unit).empty().append "<textarea id='#{id}'>#{src}</textarea>"
  #     ed = new SimpleMDE element: $("##{id}")[0]
  #   )

  constructor: (@id) ->
    $("#v"+@id).hide()
    @editor = new SimpleMDE
      element:      $("#e"+@id)[0]
      autofocus:    true
      forceSync:    true
      spellChecker: false

    @editor.codemirror.on "keyup", (e, value) =>
      main.event.editor_keyup(@, value.key)

  save_and_close: ->
    $("#e"+@id).hide()
    $("#v"+@id).show()
    @editor.toTextArea()
    @editor = null;
