class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
        render 'new'
    end
  end

  def show

  end

  def update

  end

  #------------------------------------------------------------
  #                  PRIVATE AREA
  #------------------------------------------------------------
  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !helpers.logged_in? || !helpers.current_user.admin?
      flash[:danger] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end

end