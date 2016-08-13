class PostsController < ApplicationController
    
    def new 
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id # assign the post to the user who created it.
        respond_to do |f|
            if (@post.save) 
                f.html { redirect_to "", notice: "Post created!" }
            else
                f.html { redirect_to "", notice: "Error: Post Not Saved." }
            end
        end
    end
    def show
        @post = Post.find(params[:id])
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
        params.require(:post).permit(:user_id, :content)
        
    end
    
end