# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

tmpl = (id, word) ->
  "<a class='vcard small-12 button' href='/words/#{id}'>#{word}</li>"

do_word_list = () -> 
  $("#word-list").append tmpl o.word.i,o.word.w  for o in gon.words if gon

jQuery ->
  $("#word-list").clear
  do_word_list()
