class @Search

  constructor: ({@tag, call}) ->
    $(@tag).append("<input>")
    $(@tag).keyup (e, v)=> call(@tag, v)
    @input = $(@tag+" input")

  value: ->
    @input.val()
