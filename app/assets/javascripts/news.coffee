# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

tmpl = (id, word) ->
  "<a class='word vcard small-12 button' id='#{id}'>#{word}</li> "


do_word_list = () -> 
  $("#word-list").append tmpl o.word.i,o.word.w  for o in gon.words if gon

$ ->
  $("#word-list").clear
  do_word_list()

  $(".word").click ->
    $.ajax
      url: "/words/#{this.id}.json"
      method: 'get'
      success: (data) ->
        $('#myModal .w').text(data.word)
        $('#myModal .m').text(data.means)
        $('#myModal .m').text("test")
        $('#myModal').foundation('reveal', 'open');
      error: ->
        alert "error"

