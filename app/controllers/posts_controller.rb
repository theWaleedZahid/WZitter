class PostsController < ApplicationController
    
    def new 
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id # assign the post to the user who created it.
        respond_to do |f|
            if (@post.save)
                track_activity @post
                f.html { redirect_to "", notice: "Post created!" }
            else
                f.html { redirect_to "", notice: "Error: Post Not Saved." }
            end
        end
    end
    def destroy
        @post = Post.find(params[:id])
		@post.destroy
		track_activity @post
		redirect_to root_path
    end
    def show
        @post = Post.find(params[:id])
    end
    def hashtags
        tag = Tag.find_by(name: params[:name])
        @posts = tag.posts
    end
    def upvote
    @post = Post.find(params[:id])
    @post.liked_by current_user
    redirect_to "/user/" +  current_user.username
    end

    def downvote
    @post = Post.find(params[:id])
    @post.downvote_from current_user
    redirect_to redirect_to "/user/" +  current_user.username
    end
    
    private
    def post_params # allows certain data to be passed via form.
        params.require(:post).permit(:user_id, :content, :image)
        
    end
    
end