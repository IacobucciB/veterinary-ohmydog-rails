class CreatePaseadors < ActiveRecord::Migration[7.0]
  def change
    create_table :paseadors do |t|
      t.string :name
      t.integer :service_type
      t.string :email
      t.string :location
      t.references :plaza, foreign_key: true

      t.timestamps
    end
  end
end
