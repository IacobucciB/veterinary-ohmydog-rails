class AddIsActiveToPerros < ActiveRecord::Migration[7.0]
  def change
    add_column :perros, :is_active, :boolean, default: true
  end
end
