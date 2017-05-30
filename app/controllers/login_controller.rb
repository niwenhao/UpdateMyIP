require 'securerandom'
require 'digest'

class LoginController < ApplicationController
  def display
    @uuid = SecureRandom.uuid()
    session[:random_key] = @uuid
  end

  def login
    @uuid = session[:random_key]
    
    auth_data = Rails.application.config.admin_identify + ":" + @uuid
    
    auth_digest = Digest::SHA256.hexdigest auth_data
    if auth_digest != params["authorization"] then
      @uuid = SecureRandom.uuid()
      session[:random_key] = @uuid
      render action: :display
    else
      session[:auth_digest] = auth_digest
      redirect_to controller: :host_addresses, action: :index
    end
  end

  def logout
  end
end
