class AddFieldsToTipoTurnos < ActiveRecord::Migration[7.0]
  def change
    add_column :turnos, :dosis, :integer
    add_column :turnos, :descripcion, :string
    add_column :turnos, :peso, :integer
  end
end
