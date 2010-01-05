class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.string :nickname
      t.string :address
      t.string :port
      t.string :username
      t.string :password
      t.string :su_password

      t.timestamps
    end
  end

  def self.down
    drop_table :servers
  end
end
