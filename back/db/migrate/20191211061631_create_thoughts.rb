class CreateThoughts < ActiveRecord::Migration[5.2]
  def change
    create_table :thoughts do |t|
      t.integer :environment_id
      t.string :image

      t.timestamps
    end
  end
end
