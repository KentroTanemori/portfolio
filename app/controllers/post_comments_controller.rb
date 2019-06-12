class PostCommentsController < ApplicationController
    before_action :correct_user, only: [:destroy]
	def create
		post_image = PostImage.find(params[:post_image_id])
		comment = current_user.post_comments.new(post_comment_params)
		comment.post_image_id = post_image.id
		comment.save
		redirect_to post_image_path(post_image)

	end

    def destroy
    	@post_comment = PostComment.find(params[:id])
    	post_image = PostImage.find(params[:post_image_id])
    	@post_comment.destroy
    	redirect_to post_image_path(post_image)
    end

	private

	def correct_user
		post_comment = PostComment.find(params[:id])
		post_image = PostImage.find(params[:post_image_id])
		if current_user != post_comment.user
			redirect_to post_image_path(post_image.id)
		end
	end

	def post_comment_params
		params.require(:post_comment).permit(:user_id, :post_image_id, :comment)
	end

end
