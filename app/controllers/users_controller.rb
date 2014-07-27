class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_before_destroy, :only => [:destroy]

  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 20).order('first_name, last_name')
  end
  
  def show
     if params[:id].to_i == current_user.id || current_user.admin
        @user = User.find(params[:id])
        @boards = @user.boards.paginate(:page => params[:page], :per_page => 5).order('name')
      else
       raise("not found")
     end
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

    def check_user_before_destroy
      if current_user && params[:id] != current_user.id && current_user.admin
        return true
      end
      return false
    end
end
