module Api::V1
	class EmotionsEmotionLabelsController < ApplicationController
		skip_before_action :authenticate!, only: [:index, :create, :update, :destroy]
		protect_from_forgery :except => [:create]

		def create
			EmotionsEmotionLabel.transaction do
				emotions_percent_params["percent"].each do |emotion_percent|
					@emotion_percent = EmotionsEmotionLabel.new(percent: emotion_percent)
					@emotion_percent.save!
				end
			end
				response_success(:emotions_emotion_label, :create)
			rescue => e
				response_bad_request
		end

		def emotions_percent_params
      params.require(:emotions_emotion_label).permit(percent: [])
		end
	end
end
