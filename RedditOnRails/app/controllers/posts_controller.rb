class PostsController < ApplicationController

    def new
        @post = Post.new
    end

    def create 
        @post = current_user.posts.new(post_params)
        if @post.save
            redirect_to post_url(@post.id)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    def edit
    end
    
    def update
    end

    def destroy
    end

    private
    def post_params
        params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end
end