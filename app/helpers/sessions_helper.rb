module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id])
    rescue

    end

  end

  def signed_in?
    !current_user.nil?
  end
  def admin_user?
    current_user.site_admin?
  end
  def sign_out
    self.current_user = nil
    session[:user_id] = nil
    reset_session
  end

  def current_user?(user)
    user == current_user
  end
  def check_auth
    unless signed_in?
      flash[:error] = "You must be signed in to access this function"
      redirect_to signin_path
    end
  end
  def check_admin
    check_auth
    unless admin_user?
      flash[:error] = "This is only for admins"
      redirect_to root_pathz
    end
  end
end
