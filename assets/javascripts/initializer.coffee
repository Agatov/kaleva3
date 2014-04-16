$ ->

  $('#models').bxSlider({
    nextSelector: '#next-model',
    prevSelector: '#prev-model',
    nextText: "<img src='/images/right_arrow_icon_60.png'>",
    prevText: "<img src='/images/left_arrow_icon_60.png'>",
    pagerCustom: '#models-pager'
  })

  $('#show-form').on 'click', ->
    $('.modal-overlay').show()
    $('.modal-form').css('top', '-1000px')

    $('.modal-overlay').unbind()
    $('.modal-overlay').on 'click', ->
      hide_form()

    $('.modal-overlay').animate({'opacity' : '0.6'}, 200, ->
      $('.modal-form').show()
      $('.modal-form').animate({'top': '50%'}, 200)
    )

  $('#hide-thank-you').on 'click', ->
    hide_thank_you()

  $('.send-order').on 'click', ->

    username = $(@).parent().find('input[name=username]')
    phone = $(@).parent().find('input[name=phone]')
#    email = $(@).parent().find('input[name=email]')

    shake_fields = []

    if username.val() < 2
      shake_fields.push username

    if phone.val() < 10
      shake_fields.push phone

    if shake_fields.length > 0
      shake_field(field) for field in shake_fields
      return false

    $.post(
      '/orders.json',
      {
        'order[username]': username.val(),
        'order[phone]': phone.val(),
#        'order[email]': email.val()
      }
    )


    show_thank_you()


#    $('.modal-form').animate({'top': '-1000px'}, 300, ->
#      show_thank_you()
#    )

#    reach_goal 'new_order'




window.hide_form = ->
  $('.modal-form').animate {'top': '-2000px'}, 500, ->
    $('.modal-form').hide()
    $('.modal-overlay').animate {'opacity': '0'}, 300, ->
      $('.modal-overlay').hide()


window.show_thank_you = ->

  $('.modal-overlay').unbind()
  $('.modal-overlay').on 'click', ->
    hide_thank_you()

  $('.modal-overlay').show()
  $('.modal-thank-you').css('right', '-500px')
  $('.modal-thank-you').show()

  $('.modal-overlay').animate({'opacity' : '0.6'}, 200, ->
    $('input').val('')
    $('.modal-thank-you').animate({'right': '50%'}, 500)
  )

window.hide_thank_you = ->
  $('.modal-thank-you').animate {'top': '-2000px'}, 500, ->
    $('.modal-thank-you').hide()
    $('.modal-overlay').animate {'opacity': '0'}, 300, ->
      $('.modal-overlay').hide()


window.shake_field = (field) ->
  shake(field, i) for i in [1..10]


window.shake = (field, i) ->

  if i%2
    field.animate({width: '-=30'}, 100)
  else
    field.animate({width: '+=30'}, 100)

window.reach_goal = (goal) ->
#  yaCounter24590714.reachGoal(goal)



