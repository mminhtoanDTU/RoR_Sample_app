class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def show
        if !logged_in?
            redirect_to login_path
        end
        @micropost =  Micropost.find(params[:id])
    end

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save 
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end
    end

    def edit
        @micropost = Micropost.find(params[:id])
    end

    def update
        @micropost = Micropost.find(params[:id])
        if @micropost.update(micropost_params)
            flash[:success] = "Post updated"
            redirect_to @micropost
        else
            render 'edit'
        end
    end
    
    def destroy
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to root_url
        # request.referrer ||
    end

    private

        def micropost_params
            params.require(:micropost).permit(:content, :picture)
        end

        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url if @micropost.nil?
        end
end
