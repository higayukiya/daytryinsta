class Api::CommentsController < Api::ApplicationController

    def index
        @timelines = Timeline.find(params[:timelines_id])
        comment = @timelines.comments

        render json:comment
    end

    def create
        @timeline = Timeline.find(params[:timelines_id])
        @comment = @timeline.comments.build(comment_params)
        @comment.save!

        render json: @comment
    end


    private
    def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id, timeline_id: params[:timelines_id])
    end
end
