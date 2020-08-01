class CreateWineries < ActiveRecord::Migration[5.2]
  def change
    create_table :wineries do |t|
      t.string :name, :limit => 256, :null => false
      t.timestamps
    end
    add_reference :wineries, :locations, foreign_key: true
  end
end