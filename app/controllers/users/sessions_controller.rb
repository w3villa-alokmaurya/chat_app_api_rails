# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed in sucessfully.'},
        data: resource,
      }
    else
      render json: {
        status: {message: "Email or password is wrong!. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unauthorized
    end
  end
  

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
        current_user = User.find(jwt_payload['sub'])
        if current_user
          sign_out(current_user)
          render json: {
            status: { code: 200, message: 'User Logout Successfully.'}
          }, status: :ok
        else
          render json: {
            status: { code: 401, message: 'Unauthorized!' }
          }, status: :unauthorized
        end
      rescue JWT::DecodeError => e
        render json: {
          status: { code: 401, message: 'Invalid Token!', errors: e.message }
        }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound => e
        render json: {
          status: { code: 404, message: 'User Not Found!', errors: e.message }
        }, status: :not_found
      end
    else
      render json: {
        status: { code: 401, message: 'Authorization Header Missing!' }
      }, status: :unauthorized
    end
  end
end
