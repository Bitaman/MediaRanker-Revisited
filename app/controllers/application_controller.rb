class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

  def render_404
    
    raise ActionController::RoutingError.new("Not Found")
  end

  private

  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def oath_login
    user = User(session[:user_id]) if session[:user_id]
    unless user
      flash[:status] = :failure
      flash[:result_text] = "you must be logged in to view this page"
      redirect_to root_path
    end
  end
end
