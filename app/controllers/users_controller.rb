class UsersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :site_admin_logged_in?, :only => [:update]
  before_action :check_user_before_destroy, :only => [:destroy]

  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 20).order('created_at DESC, first_name, last_name')    
    respond_to do |format|
      format.html
      format.csv { render text: @users.generate_csv(["first_name", "last_name", "email", "created_at"]) }
    end
  end
  
  def show
     if params[:id].to_i == current_user.id || current_user.admin
        @user = User.find(params[:id])
        @boards = @user.boards.paginate(:page => params[:page], :per_page => 5).order('name')
      else
       raise("not found")
     end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User admin status updated."
    else
      flash[:failure] = "User admin status not updated."
    end
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    for board in @user.boards.all
      board.update_attribute(:user_id, nil)
    end
    @user.destroy
    flash[:success] = "The user has been deleted."
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:admin)
    end

    def check_user_before_destroy
      if current_user && params[:id] != current_user.id && current_user.admin
        return true
      end
      return false
    end
end
