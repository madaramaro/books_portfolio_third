class CardsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :set_book, only: [:new, :create, :edit]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def index
    if params[:search].present?
      @cards = Card.joins(:book).where('books.title LIKE ? OR books.author LIKE ? OR cards.text LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order(created_at: :desc)
    else
      @cards = Card.all.order(created_at: :desc)
    end
  end
  
  def new
    @card = @book.cards.build
  end

  def create
    @card = @book.cards.build(card_params)
    @card.user = current_user

    if @card.save
      redirect_to cards_path
    else
      render :new
    end
  end

  def show
    @user = @card.user
    @sns_url = generate_sns_url(@user.sns_type, @user.sns_username)
  end

  def edit
    # 編集権限チェックは before_action で行う
  end
  
  def update
    if @card.update(card_params)
      redirect_to card_path(@card), notice: 'カードが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path, notice: 'Card was successfully deleted.'
  end
  
  private
  def set_card
    @card = Card.includes(:book).find(params[:id])
  end

  def set_book
    @book = params[:book_id] ? Book.find(params[:book_id]) : @card.book
  end
  
  def check_owner
    unless current_user == @card.user
      redirect_to cards_path, alert: "編集権限がありません"
    end
  end

  def card_params
    params.require(:card).permit(:text)
  end
  
end
