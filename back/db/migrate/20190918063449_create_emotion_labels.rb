class CreateEmotionLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :emotion_labels do |t|
      t.string :category

      t.timestamps
    end
  end
end
