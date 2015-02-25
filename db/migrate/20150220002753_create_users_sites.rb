class CreateUsersSites < ActiveRecord::Migration
  def change
    create_table :users_sites do |t|
    	t.references :users
    	t.references :sites
    	t.string :favorite

    	t.timestamps null: false
    end
  end
end
