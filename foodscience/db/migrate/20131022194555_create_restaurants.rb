class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :rest_name, null: false, limit: 50
      t.string :rest_cuisine, null: false, limit: 20
      t.text :rest_desc
      t.string :rest_firstaddr, null: false, limit: 100
      t.string :rest_secondaddr, limit: 100
      t.string :rest_city, null: false, limit: 50
      t.string :rest_state, null: false, limit: 2
      t.string :rest_zip, null: false, limit: 10
      t.string :rest_phone, null: false, limit: 20
      t.string :rest_fax, limit: 20
      t.string :rest_url, null: false, limit: 100
      t.boolean :rest_delivers, null: false
      t.decimal :rest_fee, precision: 8, scale: 2
      t.binary :rest_menufile

      t.timestamps
    end
  end
end
