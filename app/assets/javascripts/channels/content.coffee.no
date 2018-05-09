App.content = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    # App.message.send {cmd: "refresh", element: '.content_display'}

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log data
