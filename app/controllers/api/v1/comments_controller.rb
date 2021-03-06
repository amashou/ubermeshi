class Api::V1::CommentsController < ApiController
  before_action :authenticate_api_user!

  # rescue_from ActionDispatch::Http::Parameters::ParseError do |_e|
  #   render status: 400, json: { message: 'There was a problem in the your JSON' }
  # end

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_api_user.id
    comment.post_id = params[:post_id]
    if comment.save
      render json: { status: "SUCCESS", message: "Comment created", comment: comment }
    else
      render json: { status: "FAILED", message: "Not comment created" , error: comment.errors.full_messages }
    end
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update_attributes!(comment_params)
      render json: { status: "SUCCESS", comment: comment}
    else
      render json: { status: "FAILD", errors: comment.errors.full_messages }
    end
  end

  def destroy
  end

  private

    def comment_params
      params.permit(:content)
    end

end
