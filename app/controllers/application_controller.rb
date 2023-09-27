class ApplicationController < ActionController::API
    # before_action :authenticate_user!

    private
  
    def authenticate_user!
      unless user_signed_in?
        render json: {
          error: "Unauthorized",
          message: "You must be signed in to perform this action."
        }, status: :unauthorized
      end
    end
end
