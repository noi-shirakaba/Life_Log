class AddUserIdToEnvironments < ActiveRecord::Migration[5.2]
  def change
    add_column :environments, :user_id, :integer
    add_index :environments, :user_id
  end
end
