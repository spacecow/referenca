class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = current_user ?
    t('alert.access_denied') :
    "You must first log in or sign up before accessing this page." 
    redirect_to login_url
  end

  before_filter :set_language
  helper_method :current_user, :english?
  
  def created(s); success(:created,s) end
  def deleted(s); success(:deleted,s) end
  def d(s); t(s).downcase end
  def english?; session[:language] == 'en' end
  def success(action,mdl); t("success.#{action}",:obj=>d(mdl)) end
  def updated(s); success(:updated,s) end

  def toggle_language
    session[:language] = (session[:language] == 'en' ? 'ja' : 'en')
    redirect_to :back
  end
  
  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def set_language
      I18n.locale = session[:language]
    end
end

