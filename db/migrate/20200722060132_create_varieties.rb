class CreateVarieties < ActiveRecord::Migration[5.2]
  def change
    create_table :varieties do |t|
      t.string :name, :limit => 64, :null => false
      t.timestamps
    end
  end
end
