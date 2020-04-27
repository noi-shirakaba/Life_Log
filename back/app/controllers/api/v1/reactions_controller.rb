module Api::V1
	class ReactionsController < ApplicationController
		def create
      # Action.transaction do
      Reaction.transaction do
        reaction_params["content"].each do |reaction_content|
          @reaction = Reaction.new(environment_id: reaction_params["id"], content: reaction_content)
          @reaction.save!
        end
      end
        response_success(:action, :create)
      rescue => e
        response_bad_request
    end

    def update
      Reaction.transaction do
        reaction_params["content"].each_with_index do |reaction_content, i|
          @id = i + 1
          @reaction = Reaction.find(@id)
          @reaction.update!(content: reaction_content)
        end
      end
        response_success(:reaction, :create)
      rescue => e
        response_bad_request
    end

    def reaction_params
      params.permit(:id, content: [])
    end
  end
end
