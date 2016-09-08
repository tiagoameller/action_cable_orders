class ServerNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'server_notifications'
  end
end
