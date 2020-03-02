class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.integer :environment_id
      t.string :content

      t.timestamps
    end
  end
end
