module Api::V1
  class EnvironmentsController < ApplicationController
    skip_before_action :authenticate!, only: [:index, :create, :show, :update, :destroy]
    protect_from_forgery :except => [:create, :update, :destroy]
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
      # binding.pry
      params.require(:environment).permit(:situation)
    end
  end
end