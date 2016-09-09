class App.OrdersNew

  constructor: ->
    $('.js-plus-btn').on 'click', (e) ->
      addUnits e, 'plus'
      return
    $('.js-minus-btn').on 'click', (e) ->
      addUnits e, 'minus'
      return

  addUnits = (e, operation) ->
    units_name = $(e.target).attr('id').replace("js-#{operation}-", 'js-units-')
    units_text = $("##{units_name}")
    units = parseInt(units_text.val(), 10)
    if operation == 'plus'
      units_text.val ++units
    else
      units_text.val --units
    return
