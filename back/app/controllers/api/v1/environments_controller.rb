module Api::V1
  class EnvironmentsController < ApplicationController
    protect_from_forgery
    def index
      render :json => Environment.all
    end

    def create
      @environment = Environment.new(environment_params)
      @environment.save
    end

    def environment_params
      params.require(:environment).permit(:situation)
    end
  end
end