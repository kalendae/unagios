class CreateChecksServers < ActiveRecord::Migration
  def self.up
    create_table :checks_servers, :id => false do |t|
      t.references :server, :check
    end
  end

  def self.down
  end
end
