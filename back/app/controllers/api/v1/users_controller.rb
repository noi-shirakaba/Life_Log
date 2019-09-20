module Api::V1
  class UsersController < ApplicationController
    protect_from_forgery :except => [:login]
    skip_before_action :authenticate!, only: [:login]
    
    def login
      @user = User.find_by(email: params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        render json: @user
      else
        render json: { errors: ['ログインに失敗しました'] }, status: 401
      end
    end
  end
end