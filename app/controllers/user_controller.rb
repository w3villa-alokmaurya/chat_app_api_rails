class UserController < ApplicationController
    before_action :authenticate_user!

    def index
        render json: {
            data: current_user,
            status: true
        },status: :ok
    end

    def all_users
        @users = User.all
        render json: {
            data: @users,
            status: true
        }, status: :ok
    end

    def show
        @user = User.find_by(id: params[:id])
      
        if @user
          render json: {
            data: @user,
            status: true
          }, status: :ok
        else
          render json: {
            data: "NOT FOUND",
            status: false
          }, status: :unprocessable_entity
        end
      end
      

end
