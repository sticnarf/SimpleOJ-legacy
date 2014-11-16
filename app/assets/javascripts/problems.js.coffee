# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("tbody tr").click ->
    window.location = $(this).attr("href")
  for c in $("code")
    c = $(c)
    text = c.text()
    parent = c.parent()
    c.remove()
    parent.text(text)
