class CreateChecks < ActiveRecord::Migration
  def self.up
    create_table :checks do |t|
      t.string :nickname
      t.text :execution_code
      t.text :check_regex
      t.integer :time_between_normal_checks
      t.integer :time_between_failed_checks
      t.integer :fails_before_notify

      t.timestamps
    end
  end

  def self.down
    drop_table :checks
  end
end
