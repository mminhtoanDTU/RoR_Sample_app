class CommentsController < ApplicationController

    def create
        # render json: params
        @micropost = Micropost.find(params[:micropost_id])
        @comment = @micropost.comments.create(comment_params)

        if @comment.save 
            flash[:success] = "Micropost created!"
            redirect_to request.referrer || root_url
        else
            render 'static_pages/home'
        end
    end

    def new
        @micropost = Micropost.find(params[:micropost_id])
        @comment = @micropost.comments.create(parent_id: params[:parent_id])
    end

    def edit
        render html: "Hello"
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:success] = "Comment deleted"
        redirect_to request.referrer || root_url
    end

    private
        def comment_params
            params.require(:comment).permit(:body, :parent_id, :micropost_id, :user_id)
        end
end
