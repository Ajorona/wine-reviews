class CreateDesignations < ActiveRecord::Migration[5.2]
  def change
    create_table :designations do |t|
      t.string :name, :limit => 64, :null => false
      t.timestamps
    end
    add_reference :designations, :wineries, foreign_key: true
  end
end
