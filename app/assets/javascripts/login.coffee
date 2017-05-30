# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require functions_cryptography

window.display_script = ->
	encoder = new Crypt()

	$("#login_button").click (event) ->
		uid = $('[name="username"]')
		pwd = $('[name="password"]')
		uuid = pwd.data("random")
		auth_data = uid.val() + ":" + pwd.val()
		uid.remove()
		pwd.remove()
		$('[name="authorization"]').val(encoder.HASH.sha256("#{auth_data}:#{uuid}").toString())
		$("FORM").submit()
		
		