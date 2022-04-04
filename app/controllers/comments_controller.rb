class CommentsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]

    def create
        # render json: params
        @micropost = Micropost.find(params[:micropost_id])
        @comment = @micropost.comments.create(comment_params)

        if @comment.save 
            flash[:success] = "Comment posted!"
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
        @comment = Comment.find(params[:id])
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            flash[:success] = "Comment updated"
            redirect_to @comment.micropost
        else
            render 'edit'
        end
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
