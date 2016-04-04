module ContactformHelper
  def display_full_name
    if user_signed_in?
      current_user.first_name + " " + current_user.last_name
    end
  end

  def display_email
    if user_signed_in?
      current_user.email
    end
  end
end
