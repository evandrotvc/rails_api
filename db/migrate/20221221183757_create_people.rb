class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :gender
      t.string :status, default: 'survivor'
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
