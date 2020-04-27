module Api::V1
  class EmotionLabelsController < ApplicationController
    def create
      @emotion_label_ids = []
      @emotion = Emotion.new(environment_id: emotions_params["id"])
      EmotionLabel.transaction do
        emotions_params["category"].each do |emotion_category|
          @emotion_label_ids.push(EmotionLabel.new(category: emotion_category).tap(&:save!).id)
          @emotion.save!
        end
      end
        render :json =>{"emotion": @emotion, "emotion_label": @emotion_label_ids}
      rescue => e
        response_bad_request
    end

    def update
      EmotionLabel.transaction do
        emotions_params["category"].each_with_index do |emotion_category, i|
          @id = i + 1
          @emotion_label = EmotionLabel.find(@id)
          @emotion_label.update!(category: emotion_category)
        end
      end
        response_success(:reaction, :create)
      rescue => e
        response_bad_request
    end

    def emotions_params
      params.require(:emotion_label).permit(:id, category: [])
    end
  end
end