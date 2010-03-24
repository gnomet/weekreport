class Team < ActiveRecord::Base
  
  has_many :messages
  
  validates_presence_of :name, :contact_person, :email
  
  def self.hash_for_dropdown
    all.collect { |team| [team.name, team.id.to_s] }.sort {|a,b| a[0] <=> b[0]}
  end
  
  def has_message_for_this_week?
    if messages.count == 0 
      return false
    end
    return (messages.last.is_sent == 0)
  end
  
end
