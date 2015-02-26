class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html

  # @@categories = ['Initial Visit',
  #                 'Surgery',
  #                 'Chemoradiation',
  #                 'Follow Up',
  #                 'Radiotherapy']
  #

  def after_sign_in_path_for(resource)
    if resource.instance_of? Patient
      return categories_path
    else
      return '/admin/patient/1'
    end
  end

  protected

  # Allow users to sign in with NHS number instead
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:nhs_number, :email, :password, :password_confirmation, :remember_me)
    end

    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:login, :nhs_number, :email, :password, :remember_me)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:login, :nhs_number, :email, :password, :password_confirmation, :current_password)
    end
  end
end
