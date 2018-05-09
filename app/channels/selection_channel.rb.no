class SelectionChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'selection'
    Selection.reset
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    puts "Received Selection: #{data}"
    # binding.pry
    # ActionCable.server.broadcast('selection', {receiver: "rx2",  msg: data["sender"] + ": " + data["msg"].upcase})
    # ActionCable.server.broadcast('selection', {receiver: "rx1",  msg: data["sender"] + ": " + data["msg"].downcase})
  end


end
