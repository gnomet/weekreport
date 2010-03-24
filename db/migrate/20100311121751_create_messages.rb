class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :team_id
      t.integer :is_sent, :default => 0
      t.text :completed_last_week
      t.text :will_complete_this_week

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
