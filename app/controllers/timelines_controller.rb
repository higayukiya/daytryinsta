class TimelinesController < ApplicationController
    before_action :authenticate_user!

    def show
        @timelines = Timelines.find(params[:id])
    end

    def new
        @user = current_user
        @timelines = @user.timelines.build
    end
    
    def create
        @user = current_user
        @timelines = @user.timelines.build(timelines_params)
        if @timelines.save
            redirect_to timelines_path(@user), notice: '保存できたよ'
        else
            flash.now[:error] = '保存に失敗しました'
            render :show
        end
    end

    private
    def timelines_params
        params.require(:timeline).permit(
            :title,
            album: []
        )
    end


end
