class App.OrdersIndex

  constructor: ->
    App.server_notifications =
      App.cable.subscriptions.create(
        'ServerNotificationsChannel',
        received: (data) -> location.reload() if data.kind == 'new_order'
      )

  # var heights = $('.public.category').find('article.banner').map(function(index, item){
  #   return $(item).width();
  # });
  #
  # var max = 0;
  # $(heights).each(function(index, item){
  #   max = max < item ? item : max;
  # });
  #
  # if(max < 20)
  #   max = '90%';
  #
  # $('.no-content.banner').height(max);
  #
  #   $('.js-order').
