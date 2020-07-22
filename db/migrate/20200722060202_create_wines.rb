class CreateWines < ActiveRecord::Migration[5.2]
  def change
    create_table :wines do |t|
      t.string :name, :limit => 64, :null => false
      t.timestamps
    end
    add_reference :wines, :wineries, foreign_key: true
    add_reference :wines, :varieties, foreign_key: true
    add_reference :wines, :designations, foreign_key: true
  end
end
