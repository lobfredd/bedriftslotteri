module ApplicationHelper
  def display_user_name
    if user_signed_in?
      current_user.first_name
    end
  end

  #returns full title per page
  def full_title(page_title = '')
    basis_title = "Vinlotteri"
    if page_title.empty?
      basis_title
    else
      page_title + " | " + basis_title
    end
  end

  def display_company_name
    if user_signed_in?
      current_user.company.company_name
    else
      'Bedriftslotteri AS'
    end
  end

  def display_logo
    if user_signed_in?
      # display company logo, but since we dont have the upload for it fixed yet, display the default logo
      image_url'trophy.png'
    else
      image_url'trophy.png'
    end
  end

  def get_user_role
    if user_signed_in?
      current_user.role
    end
  end

  def bootstrap_class_for flash_type
    {success: 'alert-success', error: 'alert-danger', warning: 'alert-warning', notice: 'alert-info'}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "text-center alert #{bootstrap_class_for(msg_type)} fade in") do
               concat content_tag(:button, 'x'.html_safe, class: 'close', data: {dismiss: 'alert'})
               concat message
             end)
      flash.clear
    end
    nil
  end
end

def is_lottery_created
  if current_user.company.upcoming_lotteries.present?
    true
  end
end

def prettify_date(date)
  l(date, format: :special_datetime)
end

def prettify_admin_date(date)
  l(date, format: :admin_datetime)
end

def prettify_decimal(decimal)
  number_to_percentage(decimal, precision: 2)
end
