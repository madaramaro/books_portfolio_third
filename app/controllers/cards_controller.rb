class CardsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :set_book, only: [:new, :create, :edit]
  before_action :check_owner, only: [:edit, :update, :destroy]
  
  def index
    case params[:sort]
    when 'own'
      @cards = current_user.own_cards.order(created_at: :desc)
    when 'watch'
      @cards = Card.joins(:watchlists).where(watchlists: { user_id: current_user.id }).order(created_at: :desc)
    when 'favorite'
      @cards = Card.joins(:favorites).where(favorites: { user_id: current_user.id }).order(created_at: :desc)
    else
      @cards = Card.all.order(created_at: :desc)
    end
  
    if params[:search].present?
      @cards = @cards.joins(:book).where('books.title LIKE ? OR books.author LIKE ? OR cards.text LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end
  
  def new
    @card = @book.cards.build
  end

  def create
    @book = Book.find(params[:book_id]) # または別の方法で @book をセット
    @card = @book.cards.build(card_params)
    @card.user = current_user
  
    if @card.save
      redirect_to cards_path, notice: 'Card was successfully created.'
    else
      render :new
    end
  end
  
  def show
    @user = @card.user
    if @user.nil?
      redirect_to cards_path, alert: 'User does not exist.'
    else
      @sns_url = generate_sns_url(@user.sns_type, @user.sns_username) if @user.sns_type.present? && @user.sns_username.present?
      @total_likes = Like.where(card_id: @user.cards.pluck(:id)).count
    end
  end
  
  def edit
    # 編集権限チェックは before_action で行う
    puts "@book object: #{@book.inspect}" # @bookオブジェクトのデバッグ出力
    puts "Title: #{@book.title}" # title属性のデバッグ出力
    puts "Author: #{@book.author}"
  end
  
  def update
    if @card.update(card_params)
      redirect_to book_card_path(@card.book, @card), notice: 'カードが更新されました'
    else
      render :edit
    end
  end
  

  def destroy
    @card.list_cards.destroy_all
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
    params.require(:card).permit(:text, book_attributes: [:title, :author, :publisher, :published_date, :image_url,:image])
  end
  
end
