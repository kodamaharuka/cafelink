class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.integer :genre_id, null: false
      t.string :cafe_name, null: false
      t.string :phone_number, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.string :nearest_station, null: false
      t.string :business_hours, null: false
      t.string :regular_holiday, null: false
      t.string :image_id
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
