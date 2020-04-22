class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    flash[:alert] = "User #{@user.username} and all articles created by user have been deleted"
    redirect_to users_path
  end
  
  def new
    @user=User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  #------------------------------------------------------------
  #                  PRIVATE AREA
  #------------------------------------------------------------
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if !helpers.logged_in?
      flash[:danger] = "You must be logged in to edit user accounts"
      redirect_to root_path
    else 
      if helpers.current_user != @user and !helpers.current_user.admin?
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    end
  end

  def require_admin
    if helpers.logged_in? and !helpers.current_user.admin?
      flash[:danger] = "only admin users perform that action"
      redirect_to root_path
    end
  end

end