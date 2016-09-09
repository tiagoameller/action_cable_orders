class App.OrdersShow

  constructor: ->
    App.client_notifications =
      App.cable.subscriptions.create(
        'ClientNotificationsChannel',
        received: (data) ->
          if data.kind == 'serviced_order' and data.order_id == current_order
            $('.notifications').removeClass 'hidden'
            $('.in_progress').addClass 'hidden'
            if 'vibrate' of navigator
              navigator.vibrate = navigator.vibrate || navigator.webkitVibrate || navigator.mozVibrate || navigator.msVibrate
              navigator.vibrate([100, 200, 300]) if navigator.vibrate
      )
