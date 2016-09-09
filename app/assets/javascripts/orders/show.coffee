class App.OrdersShow

  constructor: ->
    App.client_notifications =
      App.cable.subscriptions.create(
        'ClientNotificationsChannel',
        received: (data) ->
          if data.kind == 'serviced_order' and data.order_id == current_order
            $('.js-in_progress').addClass 'hidden'
            $('.js-serviced').removeClass 'hidden'
            if 'vibrate' of navigator
              navigator.vibrate = navigator.vibrate || navigator.webkitVibrate || navigator.mozVibrate || navigator.msVibrate
              navigator.vibrate([100, 200, 300]) if navigator.vibrate
      )
