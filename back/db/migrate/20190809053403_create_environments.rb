class CreateEnvironments < ActiveRecord::Migration[5.2]
  def change
    create_table :environments do |t|
      t.text :situation

      t.timestamps
    end
  end
end
