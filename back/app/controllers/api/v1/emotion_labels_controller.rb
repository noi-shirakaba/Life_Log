module Api::V1
	class EmotionLabelsController < ApplicationController

		def create
			EmotionLabel.transaction do
				emotions_category_params["category"].each do |emotion_category|
					@emotion_category = EmotionLabel.new(category: emotion_category)
					@emotion_category.save!
				end
			end
				response_success(:emotion_label, :create)
			rescue => e
				response_bad_request
		end

		def emotions_category_params
      params.require(:emotion_label).permit(category: [])
		end
	end
end