class AddPerroToTurno < ActiveRecord::Migration[7.0]
  def change
    add_reference :turnos, :perro, null: false, foreign_key: true
  end
end
