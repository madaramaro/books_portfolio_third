class WatchlistsController < ApplicationController
  def create
    card = Card.find(params[:card_id])
    current_user.watch(card)
    redirect_to cards_path
  end

  def destroy
    card = Watchlist.find(params[:id]).card
    current_user.unwatch(card)
    redirect_to cards_path
  end
end
