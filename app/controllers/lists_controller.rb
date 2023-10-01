class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show]
  before_action :check_user, only: [:edit, :update]

  def index
    @list_owner = User.find_by(id: params[:user_id])
    return redirect_to root_path, alert: 'User not found' unless @list_owner
  
    @lists = @list_owner.lists
    @selected_list_id = params[:list_id] || @lists.first&.id
    @selected_list_cards = List.find_by(id: @selected_list_id)&.cards || []
  end
  
  def new
    @list = current_user.lists.build
    @cards = current_user.own_cards.order(created_at: :desc)
  end
  
  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to lists_path, notice: 'List was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @list.update(list_params)
      redirect_to lists_path, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end
  
  def show
    @selected_list_id = params[:id]
    @lists = @user.lists
    @selected_list_cards = List.find_by(id: @selected_list_id)&.cards || []
    render :index
  end
  
  def destroy
    logger.debug "Destroy action called for list with ID: #{@list.id}"
    @list.destroy
    redirect_to lists_path, notice: 'List was successfully destroyed.'
  end
  
  private
  
  def set_list
    @list = current_user.lists.find(params[:id])
    unless @list.user == current_user
      redirect_to root_path, alert: 'Access Denied'
    end
  end
  
  def set_user
    logger.debug "Params User ID: #{params[:user_id]}"
    @user = User.find_by(id: params[:user_id]) || current_user
    logger.debug "Set User: #{@user.inspect}"
  end

  def check_user
    logger.debug "check_user called. Current User: #{current_user.inspect}, @User: #{@user.inspect}"
    unless current_user == @user
      flash[:alert] = "You are not authorized to access this page."
      redirect_to lists_path
    end
  end

  def list_params
    params.require(:list).permit(:title, card_ids: [])
  end
end
