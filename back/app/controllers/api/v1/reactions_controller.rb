module Api::V1
	class ReactionsController < ApplicationController
		def create
      Action.transaction do
        reaction_params["content"].each do |reaction_content|
          @reaction = Reaction.new(environment_id: reaction_params["id"], content: reaction_content)
          @reaction.save!
        end
      end
        response_success(:action, :create)
      rescue => e
        response_bad_request
    end

    def reaction_params
      # params.require(:action).permit(:id, action_category: [])
      params.permit(:id, content: [])
    end
  end
end
