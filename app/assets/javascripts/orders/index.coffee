class App.OrdersIndex

  constructor: ->
    App.server_notifications =
      App.cable.subscriptions.create(
        'ServerNotificationsChannel',
        received: (data) -> location.reload() if data.kind == 'new_order'
      )
