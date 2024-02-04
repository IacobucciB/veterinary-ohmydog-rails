class AddPersonaToPerros < ActiveRecord::Migration[7.0]
  def change
    add_reference :perros, :persona, null: false, foreign_key: true
  end
end
