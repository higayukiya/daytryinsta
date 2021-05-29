class TimelinesController < ApplicationController
    before_action :authenticate_user!

    def index
        @timelines = Timeline.all
        @user = current_user
        # @timeline = current_user.timelines.find(params[:id])
        # @follwer
    end
    
    def show
        @timelines = Timeline.find(params[:id])
    end

    def new
        @user = current_user
        @timelines = @user.timelines.build
    end
    
    def create
        @user = current_user
        @timelines = @user.timelines.build(timelines_params)
        if @timelines.save
            redirect_to timelines_path(@timelines), notice: '保存できたよ'
        else
            flash.now[:error] = '保存に失敗しました'
            render :show
        end
    end

    def destroy
        timelines = current_user.timelines.find(params[:id])
        timelines.destroy!
        redirect_to timelines_path(@timelines), notice: '削除に成功しました'
    end

    private
    def timelines_params
        params.require(:timeline).permit(
            :title,
            album: []
        )
    end


end
