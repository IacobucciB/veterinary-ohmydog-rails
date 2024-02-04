class AddNuevoCampoToPerros < ActiveRecord::Migration[7.0]
  def change
    add_column :perros, :sexo, :integer
  end
end
