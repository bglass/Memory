class @Search

  constructor: ({tag, call}) ->
    $(tag).append("<input>")
    $(tag).keyup -> call()
