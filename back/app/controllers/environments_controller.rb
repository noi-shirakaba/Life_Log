class EnvironmentsController < ApplicationController
  def index
    @environment = Environment.all
  end

  def new
    @environment = Environment.new
  end

  def create
  end
end
