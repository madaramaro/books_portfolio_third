class AddOnDeleteCascadeToWatchlists < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :watchlists, :users
    add_foreign_key :watchlists, :users, on_delete: :cascade
  end
end
