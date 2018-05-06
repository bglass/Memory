App.display = App.cable.subscriptions.create "DisplayChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log "Connect"

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log "Disconnect"

  received: (data) ->
    console.log "Received"
    Notification data["title"], body: data["body"]# Called when there's incoming data on the websocket for this channel
    alert("received" + data)
