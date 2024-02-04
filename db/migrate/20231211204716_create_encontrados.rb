class CreateEncontrados < ActiveRecord::Migration[7.0]
  def change
    create_table :encontrados do |t|
      t.integer :estado
      t.string :lugar
      t.date :dia
      t.text :descripcion
      t.string :color
      t.integer :tamanio

      t.timestamps
    end
  end
end
