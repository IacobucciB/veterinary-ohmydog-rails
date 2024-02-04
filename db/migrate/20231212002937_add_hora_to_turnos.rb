class AddHoraToTurnos < ActiveRecord::Migration[7.0]
  def change
    add_column :turnos, :hora, :time
  end
end

