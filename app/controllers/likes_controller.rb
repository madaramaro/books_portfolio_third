class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.create!(card_id: params[:card_id])
    redirect_to cards_path
  end

  def destroy
    @like = current_user.likes.find_by(card_id: params[:card_id])
    @like.destroy!
    redirect_to cards_path
  end
end