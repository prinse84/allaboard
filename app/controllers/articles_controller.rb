class ArticlesController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :edit, :destroy]

  def index    
    @articles = Article.order("created_at DESC")
  end
  
  def show
    @article = Article.find_by(slug: params[:slug])
  end

  def new
    if site_admin_logged_in? 
      @article = Article.new   
    else
      redirect_to articles_path, notice: "Only site admins can post Knowledge Base articles."
    end
    
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to articles_path, notice: "The article has been successfully created."
    else
      render action: "new"
    end
  end
  
  def edit
    @article = Article.find_by(slug: params[:slug])
    if !site_admin_logged_in?
      redirect_to article_path(@article.slug), notice: "Only site admins can edit this Knowledge Base articles."
    end
  end

  def update
    @article = Article.find(params[:slug])
    if @article.update_attributes(article_params)
      redirect_to article_path(@article.slug), notice: "The article has been successfully updated."
    else
      render action: "edit"
    end
  end
  
  
  private

    def article_params
      params.require(:article).permit(:title, :body)
    end
    
    
  
  
end
