$ ->
  $(".tag .remove").on "ajax:success", ->
    $(this).parent().remove()