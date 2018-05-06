if jQuery
  # alert("Coffee is ready.")
else
  alert 'jQuery is not loaded'

$ ->
  console.log "Coffee"
  selected = [0]
  $('.content_display').load("/display", {"selected": selected})
