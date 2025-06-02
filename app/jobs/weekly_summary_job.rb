class WeeklySummaryJob < ApplicationJob
  queue_as :default

  def perform
    puts "🔔 Job started at #{Time.now}"
    
    User.find_each do |user|
      puts "📧 Email sending to #{user.email}"
      WeeklySummaryMailer.summary_email(user).deliver_later
    end
    puts "✅ Job finished at #{Time.now}"
  end
  
end
