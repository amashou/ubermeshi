class Api::V1::CommentsController < ApiController
  before_action :authenticate_api_user!

  # rescue_from ActionDispatch::Http::Parameters::ParseError do |_e|
  #   render status: 400, json: { message: 'There was a problem in the your JSON' }
  # end

  def create
    comment = Comment.new( post_id: params[:post_id], user_id: current_api_user.id, comment: comment_params)
    post = Post.find(params[:post_id])
    if comment.save
      render json: { status: "SUCCESS", message: "Comment created", comments: post.comments }
    else
      render json: { status: "Failed", message: "Not comment created" }
    end
  end

  def update
  end

  def destroy
  end

  private

    def comment_params
      params.permit(:comment)
    end

end
