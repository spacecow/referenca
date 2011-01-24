class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "You must first log in or sign up before accessing this page."
    redirect_to login_url
  end

  
  helper_method :current_user
  
  def created(s); success(:created,s) end
  def deleted(s); success(:deleted,s) end
  def d(s); t(s).downcase end
  def success(action,mdl); t("success.#{action}",:obj=>d(mdl)) end
  def updated(s); success(:updated,s) end

  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end

