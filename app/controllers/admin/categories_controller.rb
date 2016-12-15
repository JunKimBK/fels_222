class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def show
  end

  def edit
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "Created_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "Created_fail"
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "Updated_Category"
      redirect_to admin_category_path
    else
      flash[:danger] = t "Update_category_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "Deleted_Category"
    else
      flash[:danger] = t "Deleted_Category_fail"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :picture
  end

  def load_category
    @category = Category.find_by_id params[:id]
    unless @category
      flash[:danger] = t "category_load_fail"
      redirect_to admin_categories_path
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "access_denied"
      redirect_to root_url
    end
  end
end
