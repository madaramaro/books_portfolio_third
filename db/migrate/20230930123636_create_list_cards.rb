class CreateListCards < ActiveRecord::Migration[7.0]
  def change
    create_table :list_cards do |t|
      t.references :list, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
