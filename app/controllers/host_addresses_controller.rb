require 'digest'

class HostAddressesController < ApplicationController
  around_action :check_login, except: [:dig_host, :setup_host]
  before_action :set_host_address, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: [:dig_host, :setup_host]
  
  def dig_host
    @dig_result = HostAddress.find_by(hostname: params[:hostname])
    if @dig_result then
      render formats: :json
    else
      render formats: :json, status: 401, action: :json_error, locals: { message: "Hostname is not found."}
    end
  end
  
  def setup_host
    req = params.require(:update_request)
    
    req_dt = DateTime.strptime(req.timestamp, "%Y/%m%d %H:%M:%S")
    curr_dt = DateTime.now
    
    if (curr_dt - req_dt).abs.to_f < 60
      hostAddress = HostAddress.find_by(hostname: req.hostname)
      if hostAddress
        digest = "#{req.timestame}#{hostAddress.secret}"
        digest = Digest::SHA256.hexdigest digest
        
        if digest == req.secret
          hostAddress.ip = req.ip
          hostAddress.save()
          render formats: :json
        else
          render formats: :json, status: 401, action: :json_error, locals: { message: "Secret is wrong."}
        end
      else
        render formats: :json, status: 404, action: :json_error, locals: { message: "Hostname is not found."}
      end
    else
      render formats: :json, status: 401, action: :json_error, locals: { message: "Timestamp is over."}
    end
  end
  
  def json_error
    
  end
  
  def check_login
    saved_digest = session[:auth_digest]

    uuid = session[:random_key]
    
    if !uuid || !saved_digest then
      redirect_to controller: :login, action: :display
    else
      auth_data = Rails.application.config.admin_identify + ":" + uuid
      
      auth_digest = Digest::SHA256.hexdigest auth_data
      
      if saved_digest == auth_digest then
        yield
      else
        redirect_to controller: :login, action: :display
      end
    end
  end

  # GET /host_addresses
  # GET /host_addresses.json
  def index
    @host_addresses = HostAddress.all
  end

  # GET /host_addresses/1
  # GET /host_addresses/1.json
  def show
  end

  # GET /host_addresses/new
  def new
    @host_address = HostAddress.new
  end

  # GET /host_addresses/1/edit
  def edit
  end

  # POST /host_addresses
  # POST /host_addresses.json
  def create
    @host_address = HostAddress.new(host_address_params)
    respond_to do |format|
      if @host_address.save
        format.html { redirect_to @host_address, notice: 'Host address was successfully created.' }
        format.json { render :show, status: :created, location: @host_address }
      else
        format.html { render :new }
        format.json { render json: @host_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /host_addresses/1
  # PATCH/PUT /host_addresses/1.json
  def update
    respond_to do |format|
      if @host_address.update(host_address_params)
        format.html { redirect_to @host_address, notice: 'Host address was successfully updated.' }
        format.json { render :show, status: :ok, location: @host_address }
      else
        format.html { render :edit }
        format.json { render json: @host_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /host_addresses/1
  # DELETE /host_addresses/1.json
  def destroy
    @host_address.destroy
    respond_to do |format|
      format.html { redirect_to host_addresses_url, notice: 'Host address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host_address
      @host_address = HostAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_address_params
      p "host_address_params"
      params.require(:host_address).permit(:hostname, :ip, :secret)
    end

end
