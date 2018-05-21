class @Editor

  constructor: ({@unit}) ->
    resource = @unit.dataset.resource
    id = "t"+@unit.id
    $.get(/editor/, resource: resource, (data) =>
      src = data["source"]
      $(@unit).empty().append "<textarea id='#{id}'>#{src}</textarea>"
      ed = new SimpleMDE element: $("##{id}")[0]
    )
