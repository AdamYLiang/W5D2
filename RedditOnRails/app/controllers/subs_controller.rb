class SubsController < ApplicationController 
    before_action :ensure_logged_in, except: [:index, :show]

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
    end

    def update
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end