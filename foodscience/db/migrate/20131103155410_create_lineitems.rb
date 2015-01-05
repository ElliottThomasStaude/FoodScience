class CreateLineitems < ActiveRecord::Migration
  def change
    create_table :lineitems do |t|
      t.integer :line_part, null: false
      t.integer :line_order, null: false
      t.string :line_name, null: false, limit: 100
      t.decimal :line_price, null: false, precision: 8, scale: 2
      t.text :line_notes

      t.timestamps
    end
  end
end
