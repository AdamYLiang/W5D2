class SubsController < ApplicationController 
    before_action :ensure_logged_in, except: [:index, :show]
    before_action :ensure_moderator, only: [:edit, :update]

    def new
        @sub = Sub.new
    end

    def create
        @sub = current_user.subs.new(sub_params)
        if @sub.save
            redirect_to sub_url(@sub.id)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def show
        @sub = Sub.find(params[:id])
    end

    def edit
        @sub = Sub.find(params[:id])
    end

    def update
        @sub = current_user.subs.find(params[:id])
        if @sub && @sub.update(sub_params)
            redirect_to sub_url(@sub.id)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end

    def ensure_moderator
        @sub = Sub.find(params[:id])
        unless @sub.moderator == current_user
            flash.now[:errors] = ["Must be owner of sub to edit"]
            render :show
        end
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end