class PagesController < ApplicationController

  before_filter(:except => [:about, :faq]) { accept_role :user}

  def edit_user
    @user = current_user
  end

  def update_user
    if current_user.update_attributes(user_params)
      flash[:success] = 'Bruker oppdatert!'
      redirect_to edit_user_path
    else
      # render 'admin/edit_lottery'
    end

  end

  def faq

  end

  def about
    @contact_form = Contactform.new
  end

  def my_page
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
