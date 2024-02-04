class ChangeFranjaHorariaDataTypeInTurnos < ActiveRecord::Migration[7.0]
  def change
    change_column :turnos, :franja_horaria, :integer, using: 'franja_horaria::integer'
  end
end
