class Admin::SessionsController < Devise::SessionsController
  layout 'application' # only: [:login, :sign_up]

  def login
    # super
  end

  def sign_up
    @user = User.new
  end


  def after_sign_in_path_for(resource)
    new_admin_post_path
  end

  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
      when :admin then new_admin_post_path
    end
  end
end
