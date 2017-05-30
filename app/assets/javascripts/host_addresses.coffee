# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require functions_cryptography

window.reformat_input_form = ->
	pwd = $('#host_address_scret')
	pwd.change (e) ->
		secret = pwd.val()
		crypt = new Crypt()
		digest = crypt.HASH.sha256(secret).toString()
		pwd.val(digest)