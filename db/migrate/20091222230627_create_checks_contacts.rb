class CreateChecksContacts < ActiveRecord::Migration
  def self.up
    create_table :checks_contacts do |t|
      t.references :contact, :check
    end
  end

  def self.down
  end
end
