class ReportMailer < ActionMailer::Base
  
  WEEKREPORTER_FROM_ADDRESS = "no-reply@OtaSizzle.Weekreport"
  
  def request_reports(team)
    logger.info "Sending request for report for #{team.name} to #{team.email}."
    
    recipients team.email
    from       "\"OtaSizzle Week Reporter\" <#{WEEKREPORTER_FROM_ADDRESS}>"
    subject    "Time for short week reporting"
     
    body :team => team
  end
  
  def reminder(team)
    logger.info "Sending reminder for #{team.name} to #{team.email}."
    
    recipients team.email
    from       "\"OtaSizzle Week Reporter\" <#{WEEKREPORTER_FROM_ADDRESS}>"
    subject    "Please remember to submit a short report for OtaSizzle weekly mail"
    
    body :team => team
  end
  
  def weekly_report
    logger.info "Sending weekly report"
     
    recipients REPORT_RECIPIENTS
    from       "\"OtaSizzle Week Reporter\" <#{WEEKREPORTER_FROM_ADDRESS}>"
    
    subject    "OtaSizzle weekly report, week #{Date.today.cweek}"
    body       
  end
  
  def ReportMailer.send_requests
    Team.all.each do |team|
      deliver_request_reports(team)
    end
  end
  
  def ReportMailer.send_reminders
    logger.info { "Sending reminders." }
    Team.all.each do |team|
      puts "Team #{team.name} has message for this week? #{team.has_message_for_this_week?}"
      unless (team.has_message_for_this_week?)
        puts "Delivering reminder to #{team.name}"
        deliver_reminder(team)
      end
    end
  end
  
  def ReportMailer.send_report
    logger.info { "Sending the weekly report." }
    deliver_weekly_report
    Team.all.each do |team|
      team.messages.last.update_attribute(:is_sent, 1) unless (team.messages.last.nil?)
    end  
  end
  
end