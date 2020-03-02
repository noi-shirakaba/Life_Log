class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.integer :environment_id
      t.string :action_category

      t.timestamps
    end
  end
end
