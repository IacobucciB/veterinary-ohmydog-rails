class CreateCampaniaDonacions < ActiveRecord::Migration[7.0]
  def change
    create_table :campania_donacions do |t|
      t.string :nombre
      t.string :descripcion
      t.datetime :fecha_final
      t.decimal :monto_actual, precision: 10, scale: 2  # Nuevo campo 'monto_actual'
      t.decimal :monto_objetivo, precision: 10, scale: 2  # Nuevo campo 'monto_objetivo'

      t.timestamps
    end
  end
end
