class AddParentIdToMovements < ActiveRecord::Migration[4.2]
  def change
    add_column :movements, :parent_id, :integer
    add_index :movements, :parent_id
    add_foreign_key :movements, :movements, column: :parent_id
  end
end
