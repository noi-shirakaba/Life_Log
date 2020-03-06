class EmotionsEmotionLabel < ApplicationRecord
  belongs_to :emotion
  belongs_to :emotion_label
end
