class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :message
      t.string :occation
      t.datetime :reserved_at

      t.timestamps null: false
    end
  end
end
