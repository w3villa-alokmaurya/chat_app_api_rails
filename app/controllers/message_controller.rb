class MessageController < ApplicationController
    before_action :authenticate_user!

    def index
      reciever_id = params[:reciever_id]
      messages = Message.where(sender_id: current_user.id, reciever_id: reciever_id).or(Message.where(sender_id: reciever_id, reciever_id: current_user.id))
      render json: messages
    end

    def create
        @message = Message.new(message_params)
        @message.sender_id = current_user.id
        if User.exists?(@message.reciever_id) && @message.save
            render json: @message, status: :created
        else
            render json: { error: 'Receiver does not exist or message could not be saved' }, status: :unprocessable_entity
        end
    end

    private

    def message_params
        params.require(:message).permit(:content, :reciever_id)
    end
  
end
