class Api::V1::ReplysController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_reply, only: :destroy
  
  def create
    reply = Reply.new(reply_params)
    reply.user_id = current_api_user.id
    reply.comment_id = params[:comment_id]
    if reply.save
      render json: { status: "SUCCES", message: "Send a reply!", reply: reply}
    else
      render json: { status: "Faild", message: "Failed replying", error: reply.errors }
    end
  end

  def update
    reply = Reply.find(params[:id])
    if reply.update_attributes!(reply_params)
      render json: { status: "SUCCESS", reply: reply }
    else
      render json: { status: "FAILED", error: reply.errors.full_messages }
    end

  end

  def destroy
    reply = Reply.find(params[:id])
     if reply.destroy
      render json: { status: "SUCCES", message: "Send a reply!"}
     end
  end

  private
    def reply_params
      params.require(:reply).permit(:content)
    end

    def set_reply
      reply = Reply.find(params[:id])
    end
end
