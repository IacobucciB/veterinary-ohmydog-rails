class ChangeEstadoDataTypeInTurnos < ActiveRecord::Migration[7.0]
  def change
    change_column :turnos, :estado, :integer, using: 'estado::integer'
  end
end
