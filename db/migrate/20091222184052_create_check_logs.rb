class CreateCheckLogs < ActiveRecord::Migration
  def self.up
    create_table :check_logs do |t|
      t.boolean :failed
      t.text :output

      t.timestamps
    end
  end

  def self.down
    drop_table :check_logs
  end
end
