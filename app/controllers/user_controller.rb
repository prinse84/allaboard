class UserController < ApplicationController
  
  def show
     if params[:id].to_i == current_user.id
        @user = User.find(params[:id])
      else
       raise("not found")
     end
  end
end
