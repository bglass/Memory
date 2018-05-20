class @Editor

  constructor: ({@unit}) ->
    file = @unit.dataset.file
    console.log file, @unit.id
    $.get(/editor/, path: file, (data) =>
      md = data["markdown"]
      $(@unit).empty().append "<textarea>#{md}</textarea>"
      # ed = new SimpleMDE element: unit[0]
    )
