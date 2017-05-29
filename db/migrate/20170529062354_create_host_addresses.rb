class CreateHostAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :host_addresses do |t|
      t.string :hostname
      t.string :ip

      t.timestamps
    end
    add_index :host_addresses, :hostname, unique: true
  end
end
