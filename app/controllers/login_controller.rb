require 'securerandom'

class LoginController < ApplicationController
  def display
    @uuid = SecureRandom.uuid()
    session[:random_key] = @uuid
  end

  def login
  end

  def logout
  end
end
