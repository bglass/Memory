window.App.Models ?= {}

class App.Models.Tree
  this.update =(tag, data) ->
    $(tag).tree("loadData", data)

  this.no_data = ->
    return [{name: '...'}]

$ ->
  data = App.Models.Tree.no_data()
  $('.folder_tree').tree  data: data
  $(  '.note_tree').tree  data: data
  $(   '.tag_tree').tree  data: data
