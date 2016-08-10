class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :finalized_date

      t.timestamps null: false
    end
  end
end
