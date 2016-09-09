window.App ||= {}

App.init = ->
  App.cable = ActionCable.createConsumer()
  new App.OrdersNew if $("body.orders.new").length > 0
  new App.OrdersIndex if $("body.orders.index").length > 0
  new App.OrdersShow if $("body.orders.show").length > 0

# event binding
$(document).on "turbolinks:load", -> App.init()
