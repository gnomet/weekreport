class Message < ActiveRecord::Base
  
  belongs_to :team
  
  validates_presence_of :team_id, :message => "is not selected"
  validates_length_of :completed_last_week, :within => 1..500
  validates_length_of :will_complete_this_week, :within => 1..500
  
end
