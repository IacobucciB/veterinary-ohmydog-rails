class AddPersonaToAdopciones < ActiveRecord::Migration[7.0]
  def change
    add_reference :adopcions, :persona, null: false, foreign_key: true
  end
end
