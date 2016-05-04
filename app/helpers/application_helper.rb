module ApplicationHelper

  def site_admin_logged_in?
    if current_user #Is a user logged in?
      if current_user.admin #If the logged in user has the admin flag set to True
        return true
      end
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def generate_twitter_url (name)
    twitter_url = 'https://twitter.com/' + name.strip
  end

end
