class AddSnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sns_type, :string
    add_column :users, :sns_username, :string
  end
end
