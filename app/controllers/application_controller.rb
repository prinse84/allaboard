class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
    end
    
    def site_admin_logged_in?
      if current_user #Is a user logged in?
        if current_user.admin #If the logged in user has the admin flag set to True
          return true
        end 
      end
    end
    
    def get_categories(type)
      Category.where(:forr => type).order('name')   
    end
    
end
