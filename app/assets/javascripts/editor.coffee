class @Editor

  constructor: ({@unit}) ->
    resource = @unit.dataset.resource
    id = "t"+@unit.id
    $.get(/editor/, resource: resource, (data) =>
      md = data["markdown"]
      $(@unit).empty().append "<textarea id='#{id}'>#{md}</textarea>"
      ed = new SimpleMDE element: $("##{id}")[0]
    )
