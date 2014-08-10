class ArticlesController < ApplicationController
  
  def index    
    @articles = Article.order("created_at DESC")
  end
  
  def show
    @article = Article.find_by(slug: params[:slug])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: "The article has been successfully created."
    else
      render action: "new"
    end
  end
  
  def edit
    @article = Article.find_by(slug: params[:slug])
  end

  def update
    @article = Article.find(params[:slug])
    if @article.update_attributes(article_params)
      redirect_to articles_path, notice: "The article has been successfully updated."
    else
      render action: "edit"
    end
  end
  
  
  private

    def article_params
      params.require(:article).permit(:title, :body)
    end
  
  
end
