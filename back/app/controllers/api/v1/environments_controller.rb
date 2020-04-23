module Api::V1
  class EnvironmentsController < ApplicationController

    def index
      @environment = @user.environments.all
      render :json => @environment
    end

    def create
      @environment = @user.environments.new(environment_params)
      if @environment.save
        render :json => @environment
      else
        response_bad_request
      end
    end

    def show
      @environment = @user.environments.find(params[:id])
      @thought = @environment.thoughts
      @reaction = @environment.reactions
      @action = @environment.actions
      @emotion = @environment.emotions
      @emotions_emotion_label = EmotionsEmotionLabel.where(emotion_id: @emotion[0].id)
      @emotion_label = []
      @emotions_emotion_label.each do |emos|
        @emotion_label.push(EmotionLabel.find(emos.emotion_label_id))
      end
      render :json => {environment: @environment, thought: @thought, reaction: @reaction, action: @action, emotion: @emotion, emotions_emotion_label: @emotions_emotion_label, emotion_label: @emotion_label}
    end

    def edit
      @environment = @user.environments.find(params[:id])
      @thought = @environment.thoughts
      @reaction = @environment.reactions
      @action = @environment.actions
      @emotion = @environment.emotions
      @emotions_emotion_label = EmotionsEmotionLabel.where(emotion_id: @emotion[0].id)
      @emotion_label = []
      @emotions_emotion_label.each do |emos|
        @emotion_label.push(EmotionLabel.find(emos.emotion_label_id))
      end
      render :json => {environment: @environment, thought: @thought, reaction: @reaction, action: @action, emotion: @emotion, emotions_emotion_label: @emotions_emotion_label, emotion_label: @emotion_label}
    end
    
    def update
      @environment = @user.environments.find(params[:id])
      @environment.update(environment_params)
      render :json => @environment
    end

    def destroy
      @environment = @user.environments.find(params[:id])
      @environment.destroy
      render :json => @environment
    end
    
    def environment_params
      params.require(:environment).permit(:situation)
    end
  end
end