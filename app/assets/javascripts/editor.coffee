class @Editor

  constructor: (unit, file) ->
    console.log file
    $.get(/editor/, path: file, (data) =>
      md = data["markdown"]
      console.log md
      unit.empty().append "<textarea>#{md}</textarea>"
      ed = new SimpleMDE element: unit
    )
