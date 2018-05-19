class @Filter

  # visible: (node) ->
  #   /U/.test node.text

  sort: (a, b) ->
    return  1 if a.text.toLowerCase() > b.text.toLowerCase()
    return -1

  contains_all: (needed, have) ->
    return true if not needed.length
    for item in needed
      if not (item in have)
        return false
    return true

  contains_one: (needed, have) ->
    return true if not needed.length
    for item in needed
      if item in have
        return true
    return false

  starts_with_one: (needed, have) ->
    return true if not needed.length
    for folder in needed
      if have.startsWith folder
        return true
    return false

  subtract_tags:  (tags) ->

  get_regexp: (re) ->
    @regexp ?= RegExp ""
    try         regexp = RegExp re, 'i'
    catch then  regexp = @regexp
    @regexp = regexp

  regular_match: (re, text) ->
    text.match @get_regexp(re)
