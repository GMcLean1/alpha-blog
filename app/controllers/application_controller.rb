class ApplicationController < ActionController::Base

  def require_user
    if !helpers.logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

  def require_same_user
    if helpers.current_user != @article.user
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end

end
