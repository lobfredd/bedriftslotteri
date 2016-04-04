class ContactformController < ApplicationController
  skip_before_filter :authenticate_user!
  def new
    @contact_form = Contactform.new
  end

  def create
   # render plain: params[:contactform].inspect
    @contact_form = Contactform.new(contact_form_params)

    if @contact_form.save
      UserNotifier.send_contactform_email(@contact_form).deliver
      flash[:success] = "Meldingen er nå sendt. Takk for at du kontaktet oss."
      redirect_to kontakt_path
    else
      # flash[:error] = "Noe gikk galt under sendingen av meldingen"
      flash[:error] = @contact_form.errors.full_messages.map { |msg| msg }.join("\n")
    end

  end


  private
  def contact_form_params
    params.require(:contactform).permit(:name, :subject, :email, :img, :message)
  end
end
