class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :site_id
      t.integer :user_id
      t.timestamps
    end
  end
end
