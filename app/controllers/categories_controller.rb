class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category Saved Successfully!"
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only an admin can create a new category"
      redirect_to categories_path
    end
  end
end
