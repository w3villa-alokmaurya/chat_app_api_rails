class UserController < ApplicationController
    before_action :authenticate_user!

    def index
        render json: {
            data: current_user,
            status: true
        },status: :ok
    end
end
