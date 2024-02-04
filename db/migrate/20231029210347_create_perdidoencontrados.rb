class CreatePerdidoencontrados < ActiveRecord::Migration[7.0]
  def change
    create_table :perdidoencontrados do |per|
      per.string :tipo
      per.string :foto
      per.string :zona
      per.datetime :dia
      per.string :observacion
      per.string :estado
      per.timestamps
    end
  end
end
