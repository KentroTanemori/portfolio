class PostImagesController < ApplicationController
    before_action :correct_user, only: [:edit, :update, :destroy]
	def new
		@post_image = PostImage.new
        @post_image.images.build
        @user = current_user
        @post_images = @user.post_images
    end

    def create
    	@post_image = PostImage.new(post_image_params)
    	@post_image.user_id = current_user.id
        @user = current_user
        @post_images = @user.post_images
    	if @post_image.save
    	  redirect_to post_images_path
        else
          render :new
        end
    end

    def index
    	@post_images = PostImage.page(params[:page]).reverse_order
        @user = current_user
        @post_images1 = @user.post_images

    end

    def show
    	@post_image = PostImage.find(params[:id])
    	@post_comment = PostComment.new
        @user = current_user
        @post_images = @user.post_images
        @post_comments =  @post_image.post_comments.page(params[:page])
    end

    def edit
        @post_image = PostImage.find(params[:id])
        @user = current_user
        @post_images = @user.post_images
    end

    def update
        @post_image = PostImage.find(params[:id])
        @post_image.update(post_image_params)
        redirect_to post_image_path(@post_image.id)
    end

    def destroy
    	@post_image = PostImage.find(params[:id])
    	@post_image.destroy
        redirect_to post_images_path
    end


    private

    def correct_user
        @post_image = PostImage.find(params[:id])
      if current_user != @post_image.user
         redirect_to post_images_path
      end
    end

    def post_image_params
      	  params.require(:post_image).permit(:title, :body, images_images: [])
    end
end
