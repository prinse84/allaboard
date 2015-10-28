class ParentOrganizationsController < ApplicationController

   before_action :authenticate_user!, :only => [:index, :new, :edit]

  # index action. This will respond to /parent_organizations
  def index
    # only show page if user is an admin
    if site_admin_logged_in?
      @parent_organizations = ParentOrganization.all.paginate(:page => params[:page], :per_page => 20).order('name')
    else
      flash[:warning] = "You cannot view all organizations, you are not an admin."
      redirect_to boards_path
    end
  end
  
  # show action. This will respond to /parent_organizations/:id
  def show
    if @parent_organization = ParentOrganization.find_by(id: params[:id])
      # A valid organization was passed via :id
    else
      flash[:warning] = "The organization you are looking for does not exist"
      redirect_to parent_organizations_path
    end
  end
  
  # new action. 
  def new
    # only show page if user is an admin
    if site_admin_logged_in?
      @parent_organization = ParentOrganization.new
    else
      flash[:warning] = "You cannot create a new organization, you are not an admin."
      redirect_to parent_organizations_path
    end
  end
  
  def create
    @parent_organization = ParentOrganization.new(parent_organization_params)
    if @parent_organization.save 
      flash[:success] = "New organization created."      
      redirect_to parent_organization_path(@parent_organization)
    else
      flash[:warning] = "An error occurred."          
      render 'new'
    end
  end
  
  def edit
    # only show page if user is an admin
    if site_admin_logged_in?
      @parent_organization = ParentOrganization.find_by(id: params[:id])
    else
      flash[:warning] = "You cannot edit an organization, you are not an admin."
      redirect_to parent_organizations_path
    end
  end
  
  def update 
    @parent_organization = ParentOrganization.find(params[:id])
    if @parent_organization.update_attributes(parent_organization_params)
      flash[:success] = "Organization details updated."       
      redirect_to parent_organization_path(@parent_organization)
    else
      flash[:warning] = "An error occurred."          
      render 'edit'
    end
  end
  
  def destroy
    @parent_organization = ParentOrganization.find(params[:id])
    @parent_organization.destroy
    redirect_to parent_organizations_path
  end
    
  private
  def parent_organization_params
    params.require(:parent_organization).permit(:name, :ein)
  end
end
