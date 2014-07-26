module ApplicationHelper
  
  def site_admin_logged_in?
    if current_user #Is a user logged in?
      if current_user.admin #If the logged in user has the admin flag set to True
        return true
      end 
    end
  end
  
end
