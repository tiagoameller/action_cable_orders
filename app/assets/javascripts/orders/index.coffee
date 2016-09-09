class App.OrdersIndex

  constructor: ->
    App.server_notifications =
      App.cable.subscriptions.create(
        'ServerNotificationsChannel',
        received: (data) -> location.reload() if data.kind == 'new_order'
      )

    heights = $('.js-order').map (index, item) -> $(item).height()
    max = 0
    $(heights).each (index, item) ->  if max < item then max = item
    $('.js-order').height(max)
