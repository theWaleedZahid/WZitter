class CommentsController < ApplicationController
    def create
		@post = Post.find(params[:post_id])
		
		@comment = @post.comments.create(params[:comment].permit(:name, :body, :email))
		@post.comments.reject(&:new_record?)
		track_activity @comment
		redirect_to @post
	end
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		track_activity @comment
		redirect_to @post
	end
end
