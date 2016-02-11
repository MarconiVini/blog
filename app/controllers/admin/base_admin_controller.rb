class Admin::BaseAdminController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "admin/master"

  before_action :set_header, :check_admin_is_logged_in

  def check_admin_is_logged_in
    # redirect_to(controller: "sessions", action: "new") unless current_admin
  end
end
