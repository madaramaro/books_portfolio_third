require 'httparty'
require 'cgi' # CGI.escapeを使うために追加

class ChatsController < ApplicationController
  before_action :set_token, only: :search
  before_action :text_params, only: :search

  BASE_GOOGLE_BOOKS_URL = "https://www.googleapis.com/books/v1/volumes?q="

  def index; end

  def search
    @client = OpenAI::Client.new(access_token: @api_key)

    additional_info = "必ず存在するもので、上記条件にあった書籍を一冊選び、概要:は300文字以内で回答してください。「」不要。必ず書籍は書籍:、概要は概要:の後に表示するようにしてください。"
    full_query = "#{@query} #{additional_info}"

    response = @client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{ role: "user", content: full_query }],
        temperature: 0
      })

    Rails.logger.info(response.inspect)

    if response["error"]
      @chats = response["error"]["message"]
    else
      content = response.dig("choices", 0, "message", "content")

      title_match = content.match(/書籍: (.*)/)
      description_match = content.match(/概要: (.+)/)   

      Rails.logger.info("Content: #{content}")
      if title_match
        title = title_match[1].strip # stripを追加して不要な空白を削除
        Rails.logger.info("Title matched: #{title}")

        encoded_title = CGI.escape(title) # URI.encodeをCGI.escapeに変更
        google_response = HTTParty.get("#{BASE_GOOGLE_BOOKS_URL}intitle:#{encoded_title}")
        Rails.logger.info("Google Books API Response: #{google_response.inspect}")

        if google_response["items"] && google_response["items"].first
          book_data = google_response["items"].first["volumeInfo"]

          description = description_match ? description_match[1][0...300] : nil

          @aicard = Aibook.new(
            isbn: book_data["industryIdentifiers"] ? book_data["industryIdentifiers"].first["identifier"] : nil,
            title: book_data["title"],
            author: book_data["authors"] ? book_data["authors"].join(", ") : nil,
            publisher: book_data["publisher"],
            published_date: book_data["publishedDate"],
            description: description,
            image_url: book_data["imageLinks"] ? book_data["imageLinks"]["thumbnail"] : nil
          )
          Rails.logger.info("@aicard: #{@aicard.inspect}")

        else
          @chats = "該当する書籍名の書籍が見つかりませんでした。"
          Rails.logger.info("@chats: #{@chats}")
        end
      else
        @chats = "書籍名が見つかりませんでした。"
        Rails.logger.info("@chats: #{@chats}")
      end
    end
  end

  private

  def text_params
    @query = params[:text]
  end

  def set_token
    @api_key = Rails.application.credentials.dig(:openai, :api_key)
  end
end
