class ChangeTelefonoDataTypeToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :personas, :telefono, :bigint
  end
end
