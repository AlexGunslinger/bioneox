class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :order_id
      t.integer :order_type_id # No use
      t.integer :sample_type_id
      t.integer :quantity
      t.string :temperature
      t.string :urgency
      t.string :description

      t.timestamps
    end
  end
end
