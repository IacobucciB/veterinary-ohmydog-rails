class CreateAdopcions < ActiveRecord::Migration[7.0]
  def change
    create_table :adopcions do |a|
      a.integer :tamanio
      a.integer :sexo
      a.string :origen
      a.integer :estado
      a.timestamps
    end
  end
end
