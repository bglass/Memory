class @State

  construtor: ->
    @data = {}

  add: (k, v) ->
    @data[k] ||= v

  save_state: ->
    label = $.now()
    history.pushState(@data, "", label)
    @data = {}

  save_initial_state: ->
    @save_state()
    @data = {}
