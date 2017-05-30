class AddSecretToHostAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :host_addresses, :secret, :string, limit: 70
  end
end
