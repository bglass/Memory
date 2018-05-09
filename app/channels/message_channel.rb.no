class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    puts "Received: #{data}"
    # binding.pry
    # ActionCable.server.broadcast('messages', {receiver: "rx2",  msg: data["sender"] + ": " + data["msg"].upcase})
    # ActionCable.server.broadcast('messages', {receiver: "rx1",  msg: data["sender"] + ": " + data["msg"].downcase})
  end


end
