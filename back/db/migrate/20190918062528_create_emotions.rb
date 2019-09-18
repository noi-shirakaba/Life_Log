class CreateEmotions < ActiveRecord::Migration[5.2]
  def change
    create_table :emotions do |t|
      t.integer :environment_id

      t.timestamps
    end
  end
end