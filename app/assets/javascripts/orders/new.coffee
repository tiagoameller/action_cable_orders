class App.OrdersNew

  constructor: ->
    $('.js-plus-btn').on 'click', (e) ->
      add_units e, 'plus'

    $('.js-minus-btn').on 'click', (e) ->
      add_units e, 'minus'

    $('.js-units-input').on 'change', (e) ->
      apply_changes()

  add_units = (e, operation) ->
    units_name = $(e.target).attr('id').replace("js-#{operation}-", 'js-units-')
    units_text = $("##{units_name}")
    units = parseInt(units_text.val(), 10) || 0
    if operation == 'plus'
      units_text.val ++units
    else
      units_text.val --units
    units_text.val(0) if units < 0
    apply_changes()

  apply_changes = () ->
    enable_submin_button()
    calc_total()

  enable_submin_button = () ->
    sum = 0
    $('.js-units-input').each -> sum += (parseInt($(this).val(), 10) || 0)
    $('#js-send-btn').prop('disabled', sum == 0)

  calc_total = () ->
    sum = 0
    $('.js-units-input').each -> sum += (parseInt($(this).val(), 10) || 0) * parseFloat($(this).data('price'))
    $('#js-total').html("Total $#{sum}")
