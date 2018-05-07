class TreeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'tree'
    Client.sync_trees
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    puts "Received Tree: #{data} (normally not)"
    # binding.pry
    # ActionCable.server.broadcast('messages', {receiver: "rx2",  msg: data["sender"] + ": " + data["msg"].upcase})
    # ActionCable.server.broadcast('messages', {receiver: "rx1",  msg: data["sender"] + ": " + data["msg"].downcase})
  end


end
