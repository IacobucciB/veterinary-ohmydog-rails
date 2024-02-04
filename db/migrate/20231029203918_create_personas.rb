class CreatePersonas < ActiveRecord::Migration[7.0]
  def change
    create_table :personas do |pe|
      pe.string :nombre, null: false
      pe.string :apellido
      pe.integer :dni
      pe.integer :telefono
      pe.date :nacimiento, null: true # Permite valores nulos en la columna de nacimiento
      pe.boolean :donante
      pe.timestamps
    end

    # Agrega un índice único en la columna de dni
    add_index :personas, :dni, unique: true
  end
end
