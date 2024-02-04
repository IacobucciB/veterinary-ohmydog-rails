class RemoveFotoFromPerros < ActiveRecord::Migration[7.0]
  def change
    remove_column :perros, :foto, :string
  end
end
