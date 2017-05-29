# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require functions_cryptography

window.display_script = ->
	encoder = new Crypt()
	pwd = $('[name="password"]')
	pwd.val("")

	$("#login_button").click (event) ->
		uuid = pwd.data("random")
		pwd.css("display", "none")
		pwdstr = pwd.val()
		secret = encoder.HASH.sha256("#{pwdstr}#{uuid}")
		pwd.val(secret.toString())
		$("FORM").submit()
		
		