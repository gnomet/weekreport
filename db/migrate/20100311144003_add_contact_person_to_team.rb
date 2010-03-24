class AddContactPersonToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :contact_person, :string
  end

  def self.down
    remove_column :teams, :contact_person
  end
end
