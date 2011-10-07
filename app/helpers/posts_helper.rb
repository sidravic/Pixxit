module PostsHelper
  def posts_home?
    (controller_name == 'posts' && (action_name == 'index' || action_name == 'display'))
  end
end
