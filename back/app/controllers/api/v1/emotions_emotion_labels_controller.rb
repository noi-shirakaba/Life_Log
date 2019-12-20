module Api::V1
	class EmotionsEmotionLabelsController < ApplicationController
		def create
			EmotionsEmotionLabel.transaction do
				emotions_labels_params["emotion_label_id"].zip(emotions_labels_params["percent"]) do |label_id, emotion_percent|
					@emotion_percent = EmotionsEmotionLabel.new(emotion_id: emotions_labels_params["emotion_id"], emotion_label_id: label_id, percent: emotion_percent)
					@emotion_percent.save!
				end
			end
				response_success(:emotions_emotion_label, :create)
			rescue => e
				response_bad_request
		end

		def emotions_labels_params
			params.require(:emotions_emotion_label).permit(:emotion_id, emotion_label_id: [], percent: [])
		end
	end
end
