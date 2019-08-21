module Api::V1
  class EnvironmentsController < ApplicationController
    protect_from_forgery
    def index
      render :json => Environment.all
    end

    def create
      @environment = Environment.new(environment_params)
      if @environment.save
        response_success(:environment, :create)
      else
        response_bad_request
      end
    end

    def environment_params
      params.require(:environment).permit(:situation)
    end
  end
end