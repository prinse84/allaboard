class BoardMailer < ActionMailer::Base
  default from: "allaboardalliance@gmail.com"
  
  def suggestion_email(suggestion)
    @suggestion = suggestion
    mail(to: 'allaboardalliance@gmail.com', subject: 'A new board suggestion for our directory.')
  end
  
end
