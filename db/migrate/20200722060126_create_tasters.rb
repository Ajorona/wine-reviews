class CreateTasters < ActiveRecord::Migration[5.2]
  def change
    create_table :tasters do |t|
      add_column :name, :string, :limit => 64, :null => false
      add_column :twitter, :string, :limit => 32, :null => true
      t.timestamps
    end
  end
end