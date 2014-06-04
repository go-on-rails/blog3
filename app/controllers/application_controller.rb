class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_online
  before_filter :authenticate_user!
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :about
  end

  def check_is_admin
    if not current_user.admin?
      redirect_to root_path, notice: 'Need admin permissions'
    end
  end

  def after_sign_in_path_for(resource)
    feed_path
  end

  def set_online
    if user_signed_in?  
      $redis.set( current_user.id, nil, ex: 60 )
    end
  end
end
