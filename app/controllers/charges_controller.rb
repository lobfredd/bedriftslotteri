class ChargesController < ApplicationController

  def new
  end

  def create
   lottery = get_lottery

   if lottery && lottery.enough_tickets_left(params[:tickets].to_i)
     amount = total_amount_to_pay lottery
     customer = create_customer

     begin
       charge = charge customer, amount
       act_on_status charge, lottery
     rescue Stripe::CardError => e
       handle_error
     end
   else
     handle_error "Ingen flere lodd igjen"
   end
  end

  private
  def get_lottery
    current_user.company.lotteries.find(params[:lotteryid])
  end

  def total_amount_to_pay(lottery)
    (lottery.price_per_ticket * params[:tickets].to_i).to_i * 100
  end

  def create_customer
    Stripe::Customer.create(
        :email => current_user.email,
        :card  => params[:stripeToken]
    )
  end

  def charge(customer, amount)
    Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => amount.to_i,
        :description => 'Rails Stripe customer',
        :currency    => 'nok'
    )
  end

  def act_on_status(charge, lottery)
    if charge["paid"]
      charge_success lottery
    else
      handle_error
    end
  end

  def charge_success(lottery)
    params[:tickets].to_i.times do
      Ticket.create(user: current_user, lottery: lottery)
    end
    redirect_to root_path, notice: "Betaling fullfort!"
  end

  def handle_error(msg = "En feil har oppstatt under kjop! Vennligst prov igjen.")
    flash[:error] = msg
    redirect_to root_path
  end
end
