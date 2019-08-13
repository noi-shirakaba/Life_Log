class EnvironmentsController < ApplicationController
  def index
    @environment = Environment.all
  end

  def new
    @environment = Environment.new
  end

  def create
    @environment = Environment.new(situation_params)
    @environment.save
  end
end
