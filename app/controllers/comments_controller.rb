class CommentsController < ApplicationController

    def index
        timelines = Timeline.find(params[:timeline_id])
        @comments = timelines.comments
        # render json: comments

    end

    def create
        
    end
end
