class ClientNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'client_notifications'
  end
end
