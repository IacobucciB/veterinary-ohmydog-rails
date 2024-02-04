class CreateTarjetaCreditos < ActiveRecord::Migration[7.0]
  def change
    create_table :tarjeta_creditos do |t|
      t.string :numero
      t.string :nombre
      t.date :fecha_vencimiento
      t.integer :codigo_seguridad
      t.decimal :saldo

      t.timestamps
    end
  end
end
