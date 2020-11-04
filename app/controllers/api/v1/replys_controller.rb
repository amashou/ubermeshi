class Api::V1::ReplysController < ApplicationController
  # before_action :authenticate_api_user!
  before_action :set_reply, only: :destroy
  
  def create
    reply = Reply.new(reply_params)
    reply.user_id = current_api_user.id
    reply.comment_id = params[:comment_id]
    if reply.save
      render json: { status: "SUCCES", message: "Send a reply!", reply: reply}
    else
      render json: { status: "Faild", message: "Failed replying", error: reply.errors.full_messages}
    end
  end

  def destroy
     if reply.destroy
      render json: { status: "SUCCES", message: "Send a reply!"}
     end
  end

  private
    def reply_params
      params.require(:replyMessage).permit(:content)
    end

    def set_reply
      reply = Reply.find(params[:id])
    end
end
