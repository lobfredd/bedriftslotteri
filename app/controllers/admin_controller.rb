class AdminController < ApplicationController
  before_filter {accept_role :company}

  def index
    @lottery = Lottery.new
    @upcoming_lotteries = current_user.company.upcoming_lotteries
    @previous_lotteries = current_user.company.past_three_lotteries
  end

  def previous_lotteries
    @previous_lotteries = current_user.company.past_lotteries
  end

  def edit_lottery
    @lottery = current_user.company.lotteries.find(params[:id])
  end

  def finish_lottery
    lottery = current_user.company.lotteries.find(params[:id])
    lottery.finish_now
    redirect_to current_lottery_path(id: lottery.id)
  end

  def edit_award
    award = Award.find(params[:award][:id])
    if award.update_attributes(update_award_params)
      flash[:success] = 'Premie oppdatert!'
      redirect_to admin_path
    end
  end

  def update
    lottery = current_user.company.lotteries.find(params[:id])

    if lottery.update_attributes(new_lottery_params)
      flash[:success] = 'Lotteri oppdatert!'
      redirect_to admin_path
    else
     # render 'admin/edit_lottery'
    end
  end


  def delete
    if current_user.company.lotteries.find(params[:id]).destroy
      flash[:success] = "Trekningen er slettet"
      redirect_to admin_path
    else
      flash[:notice] = "Noe gikk galt med slettingen"
    end
  end


  def create
    lottery = Lottery.new(new_lottery_params)
    lottery.company = current_user.company
    create_awards_for lottery
    respond_to do |format|
      if lottery.save
        format.html {
          flash[:success] = 'Lotteriet ble opprettet!'
          redirect_to :back
        }
        #format.json { render :show, status: :created, location: @new_lottery }
      else
        lottery.awards.destroy
      end
    end
  end

  def edit_users
    if params[:name]
      @users = current_user.company.regular_users_matching params[:name][:search_input]
    else
      @users = current_user.company.all_regular_users
    end
  end

  def delete_user
    if
      current_user.company.users.find(params[:id]).destroy
      flash[:success] = "Bruker slettet"
      redirect_to admin_edit_users_path
    end

  end

  def edit_user
    @user = current_user.company.users.find(params[:id])
  end

  def update_user
    user = current_user.company.users.find(params[:id])

    if user.update_attributes(user_params)
      flash[:success] = 'Bruker oppdatert!'
      redirect_to admin_edit_users_path
    else
      # render 'admin/edit_lottery'
    end
  end

  private

  def create_awards_for(lottery)
    awards = params[:awards].reject(&:empty?)
    awards.each do |award|
      lottery.awards << Award.create(name: award, lottery: lottery)
    end
  end

  def new_lottery_params
    params.require(:lottery).permit(:number_of_tickets, :price_per_ticket, :start_date)
  end

  def update_award_params
    params.require(:award).permit(:id, :lottery_id, :name)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
