module Api::V1
  class ThoughtsController < ApplicationController
    def create
      Thought.transaction do
        thought_params["thought_content"].each do |thought|
          @thought = Thought.new(environment_id: thought_params["id"], thought_content: thought)
          @thought.save!
        end
      end
        response_success(:thought, :create)
      rescue => e
        response_bad_request
    end

    def update
      Thought.transaction do
        thought_params["thought_content"].each_with_index do |thought, i|
          @id = i + 1
          @thought = Thought.find(@id)
          @thought.update!(thought_content: thought)
        end
      end
        response_success(:thought, :create)
      rescue => e
        response_bad_request
    end

    def thought_params
      params.require(:thought).permit(:id, thought_content: [])
    end
  end
end
