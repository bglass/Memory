App.tree = App.cable.subscriptions.create "TreeChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    # App.message.send {cmd: "refresh", element: '.content_display'}

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log data
    # $(data.tag).tree("loadData", data.tree)
    App.Models.Tree.update(data.tag, data.tree)
