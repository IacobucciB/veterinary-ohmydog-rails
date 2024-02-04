class RemoveNombreFromTurnos < ActiveRecord::Migration[7.0]
  def change
    remove_column :turnos, :nombre
  end
end
