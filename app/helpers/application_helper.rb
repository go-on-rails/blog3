module ApplicationHelper
  def bs_nav_link_to(name, path)
    attr_class = 'active' if current_page?(path)
    content_tag :li, :class => attr_class do 
      link_to(name, path)
    end
  end


  def is_admin?
    current_user.username == 'admin'
  end


  def count_of_online
    $redis.dbsize
  end
end
