class Devise::Custom::RegistrationsController < Devise::RegistrationsController

  def new_company
    @user = User.new
  end

  #Creates a company and registers a company-admin-user
  def create_company
    @company = Company.new(company_name: params[:company_name], key: generate_key)
    user = registered_user
    user.company = @company
    user.role = 'company'
    @company.users << user

    if @company.save && user.save
      UserNotifier.send_signup_email(user).deliver
      authenticate!
    else
      resource_not_saved
      @company.destroy
      user.destroy
      render 'new_company'
    end
  end

  #Registers a user
  def create
    company = Company.where(key: params[:company_key]).first
    params[:user][:company_id] = company.id if company
    testresource = registered_user
    resource_saved = testresource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        UserNotifier.send_signup_email(testresource).deliver
        authenticate!
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      resource_not_saved
      respond_with resource
    end


  end

  private

  def registered_user
    build_resource(sign_up_params)
    resource
  end

  def authenticate!
    set_flash_message :notice, :signed_up if is_flashing_format?
    sign_up(resource_name, resource)
    respond_with resource, location: after_sign_up_path_for(resource)
  end

  def resource_not_saved
    clean_up_passwords resource
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :company_id, :password, :password_confirmation, :uid, :provider)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :company_id, :password, :password_confirmation, :current_password)
  end

  def generate_key
    ('a'..'z').to_a.shuffle.join[0..15]
  end

end
