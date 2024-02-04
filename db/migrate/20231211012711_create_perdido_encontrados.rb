class CreatePerdidoEncontrados < ActiveRecord::Migration[7.0]
  def change
    create_table :perdido_encontrados do |t|
      t.string :zona
      t.date :dia
      t.string :observacion
      t.integer :estado
      t.integer :tipo

      t.timestamps
    end
  end
end
