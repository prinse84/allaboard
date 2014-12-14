class ArticleMailer < ActionMailer::Base
  default from: "allaboardalliance@gmail.com"
  
  def new_comment_email(comment)
    @comment = comment
    mail(to: @comment.article.user.email, cc:'allaboardalliance@gmail.com', subject: 'A new comment has been posted for your article on All A-Board Alliance.')
  end
  
end
