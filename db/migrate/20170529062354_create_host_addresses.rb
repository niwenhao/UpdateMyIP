class CreateHostAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :host_addresses do |t|
      t.string :hostname, limit: 30
      t.string :ip, limit: 40

      t.timestamps
    end
    add_index :host_addresses, :hostname, unique: true
  end
end
