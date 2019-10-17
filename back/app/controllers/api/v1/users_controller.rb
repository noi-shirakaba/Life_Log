module Api::V1
  class UsersController < ApplicationController
    protect_from_forgery :except => [:login]
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
        response_bad_request
      end
    end

    def login
      @user = User.find_by(email: params[:user][:email])
      check_login(@user)
    end

    private 
      def check_login(user)
        if user && user.authenticate(params[:user][:password])
          response_success(:user, :create)
        else
          response_unauthorized
        end
      end
  end
end