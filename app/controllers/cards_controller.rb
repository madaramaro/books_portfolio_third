class CardsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @cards = Card.includes(:book).order(created_at: :desc)
  end
  
  def new
    @book = Book.find(params[:book_id])
    @card = @book.cards.build
  end

  def create
    @book = Book.find(params[:book_id])
    @card = @book.cards.build(card_params)
    @card.user = current_user

    if @card.save
      redirect_to cards_path
    else
      render :new
    end
  end

  def show
    @card = Card.includes(:book).find(params[:id])
    @user = @card.user
  end

  def edit
    @card = Card.find(params[:id])
    @book = @card.book
    # 編集権限を持つユーザーのみがアクセスできるようにする
    unless current_user == @card.user
      redirect_to cards_path, alert: "編集権限がありません"
    end
  end
  
  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to card_path(@card), notice: 'カードが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path, notice: 'Card was successfully deleted.'
  end
  
  private
  def card_params
    params.require(:card).permit(:text, :user_id)
  end
  
end 
