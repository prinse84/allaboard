class CategoriesController < ApplicationController

  before_action :authenticate_user!

  def index    
    if site_admin_logged_in? 
      @categories = Category.order("name")
    else
      redirect_to root_path, notice: "Only site admins can create new categories."
    end
  end
  
  def new
    if site_admin_logged_in? 
      @category = Category.new  
      @list = ["Event", "Board"] 
    else
      redirect_to categories_path, notice: "Only site admins can create new categories."
    end
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "The category has been successfully created."
    else
      render action: "new"
    end
  end
  
  def edit
    @category = Category.find(params[:id])
    @list = ["Event", "Board"]     
    if !site_admin_logged_in?
      redirect_to categories_path, notice: "Only site admins can edit this category."
    end
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path, notice: "The category has been successfully updated."
    else
      render action: "edit"
    end
  end  
  
  
  private

  def category_params
    params.require(:category).permit(:name, :forr)
  end
  
end
