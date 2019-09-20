class CreateEmotionsEmotionLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :emotions_emotion_labels do |t|
      t.integer :emotion_id
      t.integer :emotion_label_id
      t.integer :percent

      t.timestamps
    end
  end
end
