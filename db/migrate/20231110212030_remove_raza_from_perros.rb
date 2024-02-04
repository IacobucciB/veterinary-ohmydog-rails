class RemoveRazaFromPerros < ActiveRecord::Migration[7.0]
  def change
    remove_column :perros, :raza, :string
  end
end
