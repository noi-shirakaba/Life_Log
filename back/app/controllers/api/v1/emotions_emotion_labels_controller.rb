module Api::V1
	class EmotionsEmotionLabelsController < ApplicationController
		skip_before_action :authenticate!, only: [:index, :create, :update, :destroy]
		protect_from_forgery :except => [:create]

		def create
			@emotion_percent = EmotionsEmotionLabel.new(emotions_percent_params)
      if @emotion_percent.save
				response_success(:emotions_emotion_label, :create)
      else
				response_bad_request
      end
		end

		def emotions_percent_params
      params.require(:emotions_emotion_label).permit(:percent)
    end
	end
end
