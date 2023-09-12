class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.date :published_date
      t.string :image_url
      t.string :isbn
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end
