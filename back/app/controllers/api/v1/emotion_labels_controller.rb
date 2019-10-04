module Api::V1
	class EmotionLabelsController < ApplicationController
		skip_before_action :authenticate!, only: [:index, :create, :update, :destroy]
		protect_from_forgery :except => [:create]

		def create
			# binding.pry
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