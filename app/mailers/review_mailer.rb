class ReviewMailer < ActionMailer::Base
  default from: "allaboardalliance@gmail.com"
  
  def new_review_email(review, email)
    @review = review
    mail(to: email, subject: 'A new review has been submitted on our site.')
  end
end
