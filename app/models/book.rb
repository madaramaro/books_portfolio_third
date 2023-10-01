class Book < ApplicationRecord
  has_many :cards
  has_one_attached :image
  
  def self.fetch_book_details(isbn)
    cached_data = Rails.cache.fetch("book_#{isbn}", expires_in: 12.hours) do
      # APIからのデータ取得処理
      response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}")
      response.body if response.success?
    end
    JSON.parse(cached_data)
  end
end
