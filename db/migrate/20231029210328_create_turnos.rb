class CreateTurnos < ActiveRecord::Migration[7.0]
  def change
    create_table :turnos do |t|
      t.string :nombre
      t.date :dia
      t.string :franja_horaria
      t.string :estado
      t.float :monto
      t.timestamps
    end
  end
end
