class SearchHistoriesController < ApplicationController
  before_action :authenticate_user! # ユーザーがログインしていることを確認

  def index
    @search_histories = current_user.search_histories.order(created_at: :desc) # ログインしているユーザーの検索履歴を取得
  end
end
