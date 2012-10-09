class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :order_type_id
      t.integer :quantity
      t.string :temperature
      t.string :urgency
      t.integer :origin_site_id
      t.integer :delivery_site_id
      t.datetime :picked_up_at
      t.datetime :delivered_at
      t.string :tracking_number
      t.integer :carrier_id
      t.integer :submitted_by_id
      t.integer :picked_up_by_id

      t.timestamps
    end
  end
end
