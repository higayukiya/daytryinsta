class TimelineController < ApplicationController
    before_action :authenticate_user!

    def show
        @timeline = current_user
    end

    def new
        @timeline = current_user.timeline.build
    end
    
    def create
        @timeline = current_user.timeline.build(timeline_params)
        if @timeline.seve
            redirect_to timeline_path(@timeline), notice: '保存できたよ'
        else
            flash.now[:error] = '保存に失敗しました'
            render :show
        end
    end

    private
    def timeline_params
        parames.require(:timeline).permit(
            :title,
            :album
        )
    end


end
