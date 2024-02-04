class AddUserToPerson < ActiveRecord::Migration[7.0]
  def change
    add_reference :personas, :user, null: false, foreign_key: true
  end
end
