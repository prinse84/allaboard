class CommentsController < ApplicationController
  
  before_action :authenticate_user!, :only => [:new]

  def new
    @comment = Comment.new(:article_id => params[:article_id])
  end
  
  def create
    @article = Article.find_by(slug: params[:article_slug])
    @comment = @article.comments.new(comment_params)
    @comment.user_id = current_user.id
    
    if @comment.save
      # Tell the ArticleMailer to send a notification to the administrators after save
      ArticleMailer.new_comment_email(@comment).deliver
      redirect_to article_path(@article.slug), notice: "Comment saved."
    else
      render action: "new"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:text)
    end
end
