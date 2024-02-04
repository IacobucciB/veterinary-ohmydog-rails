class AddPerroToPerdidoEncontrados < ActiveRecord::Migration[7.0]
  def change
    add_reference :perdido_encontrados, :perro, null: false, foreign_key: true
  end
end
