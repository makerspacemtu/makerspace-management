# Rake task to send out weekly summary email of event counts to leadership team
desc "Rake task to send out weekly email to leadership team"
task send_weekly_update: :environment do
  puts "Running rake tasks..."
  users = User.all.where(user_type: "Admin").or(User.all.where(user_type: "Developer"))
  # users = User.all.where(email: "jjwyrzyk@mtu.edu")#.or(User.all.where(email: "jrguinn@mtu.edu"))
  if Date.today.wday == 4
    if users.count > 0
      users.each do |user|
        ApplicationMailer.event_email(user).deliver!
        puts "Emailed: #{user.email}"
      end
    end
  else
    puts "Not the correct day of week for task."
  end

  puts "Delivery procedure complete."
end
