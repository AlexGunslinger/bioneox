class CreateDcpls < ActiveRecord::Migration
  def change
    create_table :dcpls do |t|
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

    add_column :orders, :dcpl_id, :integer
    add_column :users, :dcpl_id, :integer

  end
end
