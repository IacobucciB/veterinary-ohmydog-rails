class AddUserIdToEncontrados < ActiveRecord::Migration[7.0]
  def change
    add_reference :encontrados, :user, null: true, foreign_key: true
  end
end
