class CreateTasters < ActiveRecord::Migration[5.2]
  def change
    create_table :tasters do |t|
		t.string :name, :limit => 256, :null => false
		t.string :twitter, :limit => 256, :null => true
      	t.timestamps
    end
  end
end