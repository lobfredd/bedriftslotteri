class UserNotifier < ApplicationMailer

  default :from => 'noreply@bedriftslotteri.no'

  #send signup email to the user
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => "Velkommen som bruker av Bedriftslotteri")
  end

  def send_contactform_email(params)
    @admin_email = 'martzini@gmail.com'
    @params = params
    mail( :to => @admin_email,
          :cc => @params.email,
          :from => @params.email,
          :name => @params.name,
    :subject => @params.subject,
    :message => @params.message)
  end

  def send_award_email(params)
    @params = params
    mail( :to => @params.email,
          :subject => "Du har vunnet!")
  end
end
