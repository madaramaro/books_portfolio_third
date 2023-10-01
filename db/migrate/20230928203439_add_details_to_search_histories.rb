class AddDetailsToSearchHistories < ActiveRecord::Migration[7.0]
  def change
    add_column :search_histories, :title, :string
    add_column :search_histories, :isbn, :string
    add_column :search_histories, :description, :text
    add_column :search_histories, :image_url, :string
    add_column :search_histories, :author, :string
    add_column :search_histories, :publisher, :string
    add_column :search_histories, :published_date, :string
  end
end
