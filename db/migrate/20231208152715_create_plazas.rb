class CreatePlazas < ActiveRecord::Migration[7.0]
  def change
    create_table :plazas do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
