class AddTipoRazaToAdopcions < ActiveRecord::Migration[7.0]
  def change
    add_reference :adopcions, :tipo_raza, null: false, foreign_key: true
  end
end
