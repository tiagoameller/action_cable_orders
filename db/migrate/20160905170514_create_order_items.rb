class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :plu, foreign_key: true
      t.integer :units

      t.timestamps
    end
  end
end
