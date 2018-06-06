class RemoveColumnFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, :handle
    remove_column :users, :handle, :string
  end
end
