class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_rest, null: false
      t.integer :order_organizer, null: false
      t.boolean :order_type, null: false
      t.decimal :order_cost, null: false, precision: 8, scale: 2
      t.datetime :order_time_at, null: false
      t.string :order_status, null: false, limit: 20

      t.timestamps
    end
  end
end
