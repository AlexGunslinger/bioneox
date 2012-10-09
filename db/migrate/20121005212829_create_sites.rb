class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :code
      t.text :address
      t.integer :city_id
      t.integer :state_id
      t.string :zip_code
      t.string :phone
      t.integer :user_id

      t.timestamps
    end
  end
end
