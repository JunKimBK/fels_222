class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:alert] = t "please_login"
      redirect_to login_path
    end
  end

  def following
    @title = t "following"
    set_user
    @users = @user.following.order_by_name
      .paginate page: params[:page], per_page: Settings.user.per_page
    render "show_follow"
  end

  def followers
    @title = t "followers"
    set_user
    @users = @user.followers.order_by_name
      .paginate page: params[:page], per_page: Settings.user.per_page
    render "show_follow"
  end

  private
  def set_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_exist"
      redirect_to root_url
    end
  end
end
