class BoardMailer < ActionMailer::Base
  default from: "allaboardalliance@gmail.com"
  
  def suggestion_email(suggestion)
    @suggestion = suggestion
    mail(to: 'allaboardalliance@gmail.com', subject: 'A new board suggestion for our directory.')
  end
  
  def board_claim_email(user, board)
    @board = Board.find(board)
    @user = User.find(user)
    mail(to: 'allaboardalliance@gmail.com', subject: 'A board has been claimed')
  end
  
  
end
