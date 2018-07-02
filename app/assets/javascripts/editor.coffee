class @Editor

  # constructor: ({@unit}) ->
  #   resource = @unit.dataset.resource
  #   id = "t"+@unit.id
  #   $.get(/editor/, resource: resource, (data) =>
  #     src = data["source"]
  #     $(@unit).empty().append "<textarea id='#{id}'>#{src}</textarea>"
  #     ed = new SimpleMDE element: $("##{id}")[0]
  #   )

  constructor: (@key) ->
    id = "t"+@key
    console.log id
    # ed = new SimpleMDE(element: $("##{id}")[0])
    sleep 1000
    ed = new SimpleMDE element: $("#t41")[0]
    console.log " Done"


sleep = (milliseconds) ->
  start = (new Date).getTime()
  i = 0
  while i < 1e7
    if (new Date).getTime() - start > milliseconds
      break
    i++
  return
