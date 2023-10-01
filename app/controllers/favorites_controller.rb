class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find_by(id: params[:user_id]) || current_user
    @favorites = @user.favorites
    @other_user = @favorites.first&.user || @user
  end
  
  def create
    favorite = current_user.favorites.build(card_id: params[:card_id]) # 修正した部分
    if current_user.favorites.count < 10
      if favorite.save
        redirect_to cards_path, notice: 'お気に入りに追加しました'
      else
        redirect_to cards_path, alert: 'お気に入りに追加できませんでした'
      end
    else
      redirect_to cards_path, alert: 'お気に入りは10冊までです'
    end
  end
  
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])
    if favorite&.destroy
      redirect_to cards_path, notice: 'お気に入りから削除しました'
    else
      redirect_to cards_path, alert: 'お気に入りから削除できませんでした'
    end
  end
end
