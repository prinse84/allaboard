class UsersController < ApplicationController
  
  def show
     if params[:id].to_i == current_user.id
        @user = User.find(params[:id])
        @boards = @user.boards.paginate(:page => params[:page], :per_page => 5).order('name')
      else
       raise("not found")
     end
  end
end
