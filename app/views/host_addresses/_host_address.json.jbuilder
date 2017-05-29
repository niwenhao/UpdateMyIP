json.extract! host_address, :id, :hostname, :ip, :created_at, :updated_at
json.url host_address_url(host_address, format: :json)
