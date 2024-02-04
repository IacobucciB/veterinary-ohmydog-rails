class CreatePerros < ActiveRecord::Migration[7.0]
  def change
    create_table :perros do |p|
      p.string :nombre
      p.integer :edad
      p.string :raza
      p.string :color
      p.string :descripcion
      p.string :antecedentes
      p.string :foto
      # p.belongs_to :persona, null: false, foreign_key: true
      p.timestamps
    end
  end
end
