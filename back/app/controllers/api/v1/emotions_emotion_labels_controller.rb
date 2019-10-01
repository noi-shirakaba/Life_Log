module Api::V1
	class EmotionsEmotionLabelsController < ApplicationController
		skip_before_action :authenticate!, only: [:index, :create, :update, :destroy]
		protect_from_forgery :except => [:create]

		def create
			emotions_length = emotions_percent_params["percent"].length
			success_check = 0

			emotions_percent_params["percent"].each do |emotion_percent|
				@emotion_percent = EmotionsEmotionLabel.new(percent: emotion_percent)

				if @emotion_percent.save
					success_check += 1
				end
			end

			if emotions_length == success_check
				response_success(:emotions_emotion_label, :create)
			else
				response_bad_request
			end

		end

		def emotions_percent_params
      params.require(:emotions_emotion_label).permit(percent: [])
		end
		
	end
end
