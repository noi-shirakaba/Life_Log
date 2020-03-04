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
      render :json => @environment
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