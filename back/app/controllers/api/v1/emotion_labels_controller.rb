module Api::V1
	class EmotionLabelsController < ApplicationController
		def create
			@emotion_label_id = []
			EmotionLabel.transaction do
				emotions_params["category"].each do |emotion_category|
					@emotion = Emotion.new(environment_id: emotions_params["id"])
					@emotion_label_id.push(EmotionLabel.new(category: emotion_category).tap(&:save!).id)
					@emotion.save!
				end
			end
				render :json =>{"emotion": @emotion, "emotion_label": @emotion_label_id}
			rescue => e
				response_bad_request
		end

		def emotions_params
			params.require(:emotion_label).permit(:id, category: [])
		end
	end
end