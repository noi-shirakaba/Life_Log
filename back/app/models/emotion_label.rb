class EmotionLabel < ApplicationRecord
  has_many :emotions_emotion_labels
  has_many :emotions, through: :emotions_emotion_labels
end
