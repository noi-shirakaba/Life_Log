class Emotion < ApplicationRecord
	has_many :emotions_emotion_labels
	belongs_to :environment
end
