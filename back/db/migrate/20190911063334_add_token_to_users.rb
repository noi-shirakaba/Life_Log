class AddTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string
    add_index :users, :email, unique: true
    add_index :users, :token, unique: true
  end
end
