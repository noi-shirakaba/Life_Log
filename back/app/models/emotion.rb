class Emotion < ApplicationRecord
	has_many :emotions_emotion_labels, dependent: :destroy
	has_many :emotion_labels, through: :emotions_emotion_labels
	belongs_to :environment
end
