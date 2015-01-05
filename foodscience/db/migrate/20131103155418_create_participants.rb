class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :part_user, null: false
      t.integer :part_order, null: false
      t.string :part_role, null: false, limit: 20
      t.decimal :part_cost, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
