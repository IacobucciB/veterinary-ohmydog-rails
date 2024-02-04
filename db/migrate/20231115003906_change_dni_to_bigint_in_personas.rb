class ChangeDniToBigintInPersonas < ActiveRecord::Migration[6.0]
  def change
    change_column :personas, :dni, :bigint
  end
end
