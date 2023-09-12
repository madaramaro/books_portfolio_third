class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
  
    if @book.save
      # オブジェクトを保存した後、編集ページにリダイレクトする
      redirect_to new_book_card_path(@book)
    else
      render :new
    end
  end
  
  def index
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to books_path, notice: '書籍情報が更新されました。'
    else
      render :edit
    end
  end
  

  private

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :published_date, :image_url, :isbn, :comment, :rating)
  end
end
