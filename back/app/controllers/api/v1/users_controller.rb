module Api::V1
  class UsersController < ApplicationController
    skip_before_action :authenticate!, only: [:create, :login]
    
    def create
      @user = User.new(
        email: params[:user][:email], 
        password: params[:user][:password], 
        name: params[:user][:name]
      )
  
      if @user.save
        check_login(@user)
      else
        render status: 202, json: { status: 202, message: 'Validation error', errors: @user.errors }
      end
    end

    def login
      @user = User.find_by(email: params[:user][:email])
      check_login(@user)
    end

    private 
      def check_login(user)
        if user && user.authenticate(params[:user][:password])
          render status: 200, json: { status: 200, name: user.name, token: user.token, message: "Success User #{action_name.capitalize}" }
        else
          response_unauthorized
        end
      end
  end
end