class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :description
      t.integer :points
      t.float :price
      t.timestamps
    end
    add_reference :reviews, :wines, foreign_key: true
    add_reference :reviews, :tasters, foreign_key: true
  end
end
