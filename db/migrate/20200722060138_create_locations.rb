class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name, :limit => 256, :null => false
      t.references :parent_location, class: 'Location'
      t.timestamps
    end
  end
end
	 	