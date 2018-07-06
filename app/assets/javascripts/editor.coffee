class @Editor

  # constructor: ({@unit}) ->
  #   resource = @unit.dataset.resource
  #   id = "t"+@unit.id
  #   $.get(/editor/, resource: resource, (data) =>
  #     src = data["source"]
  #     $(@unit).empty().append "<textarea id='#{id}'>#{src}</textarea>"
  #     ed = new SimpleMDE element: $("##{id}")[0]
  #   )

  Markdown = (editor) ->
    editor.data.processor = new GFMxDataProcessor
    return




  constructor: (@id) ->
    $("#v"+@id).hide()

    InlineEditor.create( $(".edit#"+@id)[0]) # , plugins: Markdown )

    # @editor.codemirror.on "keyup", (e, value) =>
    #   main.event.editor_keyup(@, value.key)

  # save_and_close: ->
  #   $("#e"+@id).hide()
  #   $("#v"+@id).show()
  #   @editor.toTextArea()
  #   @editor = null;
