$(document).ready ->

  $('.tx1').on 'change', 'input', ->
    App.message.send {sender: "tx1", msg: $(this).val() }


  $('.tx2').on 'change', 'input', ->
    App.message.send {sender: "tx2", msg: $(this).val() }
