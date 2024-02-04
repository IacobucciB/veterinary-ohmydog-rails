class AddIsLostToPerros < ActiveRecord::Migration[7.0]
  def change
    add_column :perros, :is_lost, :boolean, default: false
  end
end
