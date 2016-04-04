class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, except: [:statistics, :about, :faq]


  def accept_role(*roles)
    unless roles.include? current_user.role.to_sym
      redirect_to root_path
    end
  end


  def route_to_index
    if current_user.role == 'company'
      redirect_to admin_path
    else
      redirect_to lottery_index_path
    end
  end
  # def set_locale
  #   I18n.locale = request.compatible_language_from ["nb, en"]
  # end
end
