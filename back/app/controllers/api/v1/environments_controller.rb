module Api::V1
  class EnvironmentsController < ApplicationController
    protect_from_forgery
    def index
      @environment = Environment.all
      render :json => @environment
    end

    def create
      @environment = Environment.new(environment_params)
      if @environment.save
        response_success(:environment, :create)
      else
        response_bad_request
      end
    end

    def show
      @environment = Environment.find(params[:id])
      render :json => @environment
    end

    def update
      @environment = Environment.find(params[:id])
      @environment.update(environment_params)
      render :json => @environment
    end

    def destroy
      @environment = Environment.find(params[:id])
      @environment.destroy
      render :json => @environment
    end
    
    def environment_params
      params.require(:environment).permit(:situation)
    end
  end
end