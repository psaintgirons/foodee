class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :category
      t.integer :product_type
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
