class CreatePlus < ActiveRecord::Migration[5.0]
  def change
    create_table :plus do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
