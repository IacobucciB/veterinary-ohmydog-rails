class AddTipoTurnoToTurno < ActiveRecord::Migration[7.0]
  def change
    add_reference :turnos, :tipo_turno, null: false, foreign_key: true
  end
end
