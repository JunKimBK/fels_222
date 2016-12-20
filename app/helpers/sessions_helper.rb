module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def current_user? user
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget current_user
    session[:user_id] = nil
    @current_user = nil
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
