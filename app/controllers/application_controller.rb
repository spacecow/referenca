class ApplicationController < ActionController::Base
  protect_from_forgery

  def created(s); success(:created,s) end
  def deleted(s); success(:deleted,s) end
  def d(s); t(s).downcase end
  def success(action,mdl); t("success.#{action}",:obj=>d(mdl)) end
  def updated(s); success(:updated,s) end
end
